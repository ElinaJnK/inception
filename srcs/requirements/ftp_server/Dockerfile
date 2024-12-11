FROM alpine:3.19

ENV FTP_USER=foo \
	FTP_PASS=bar \
	GID=1000 \
	UID=1000 \
	PUBLIC_IP=0.0.0.0

RUN apk add --no-cache --update \
	vsftpd==3.0.5-r2

COPY [ "tools/vsftpd.conf", "/etc" ]
COPY [ "tools/docker-entrypoint.sh", "/" ]

ENTRYPOINT [ "./docker-entrypoint.sh" ]
CMD [ "/usr/sbin/vsftpd" ]
EXPOSE 20/tcp 21/tcp 40000-40009/tcp
HEALTHCHECK CMD netstat -lnt | grep :21 || exit 1