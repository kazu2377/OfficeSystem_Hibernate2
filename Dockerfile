# syntax=docker/dockerfile:1.6

# アプリケーションのビルド用ステージ（Maven）
FROM maven:3.9.6-eclipse-temurin-8 AS builder

# 作業ディレクトリを/appに設定
WORKDIR /app

# 依存関係情報（pom.xml）をコピー
COPY pom.xml .

# ソースコードをコピー
COPY src ./src

# テストをスキップしてMavenでビルド
RUN mvn -B -DskipTests clean package

FROM tomcat:8.5-jdk8-temurin-jammy
ENV MYSQL_DATABASE=csharp \
    MYSQL_ROOT_PASSWORD=csharp \
    TZ=Asia/Tokyo
USER root
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends mysql-server tini \
    && rm -rf /var/lib/apt/lists/*

COPY inport.sql /docker-entrypoint-initdb.d/inport.sql

RUN mkdir -p /run/mysqld \
    && chown mysql:mysql /run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql \
    && rm -rf /var/lib/mysql/* \
    && if command -v mysql_install_db >/dev/null 2>&1; then \
        mysql_install_db --user=mysql --ldata=/var/lib/mysql; \
    else \
        mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql; \
    fi

RUN mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking --socket=/run/mysqld/mysqld.sock --daemonize \
    && for i in $(seq 1 40); do \
        mysqladmin --protocol=socket ping && break; \
        sleep 1; \
    done \
    && mysql --protocol=socket -uroot -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" \
    && mysql --protocol=socket -uroot $MYSQL_DATABASE < /docker-entrypoint-initdb.d/inport.sql \
    && mysql --protocol=socket -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" \
    && mysqladmin --protocol=socket -uroot -p$MYSQL_ROOT_PASSWORD shutdown

COPY --from=builder /app/target/OfficeSystem_Hibernate2.war /usr/local/tomcat/webapps/ROOT.war
COPY docker/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

EXPOSE 8080 3306
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/startup.sh"]
