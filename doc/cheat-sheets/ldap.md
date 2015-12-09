#### LDAP

    ldapsearch -LLL -H "ldapi:/// ldap:///" -b "ou=users,ou=cms,o=nhs" dn 2> /dev/null | grep "^dn: uid" | wc -l
