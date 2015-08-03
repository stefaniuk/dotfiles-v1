#### mail

    java -jar fakeSMTP-2.0.jar \
        --start-server \
        --bind-address 127.0.0.1 \
        --port 1025 \
        --output-dir ~/emails

    echo "content" | mail \
        -s "subject" \
        -a attachment.txt \
        -S smtp=smtp://localhost \
        -S from="${USER}@${HOSTNAME}(Automated E-mail)" \
        someone@somewhere.com
