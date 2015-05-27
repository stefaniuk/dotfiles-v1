#### mail

    echo "content" | mail \
        -s "subject" \
        -a attachment.txt \
        -S smtp=smtp://localhost \
        -S from="${USER}@${HOSTNAME}(Automated E-mail)" \
        someone@somewhere.com
