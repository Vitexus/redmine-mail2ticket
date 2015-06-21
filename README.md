redmine-mail2ticket
===================

Debian package to get mail and mage an issue from it

Installation
------------

    wget -O - http://v.s.cz/info@vitexsoftware.cz.gpg.key | sudo apt-key add -
    echo deb http://v.s.cz/ stable main | sudo tee /etc/apt/sources.list.d/vitexsoftware.list
    sudo aptitude update
    sudo aptitude install redmine-mail2ticket

First time wizard help you create initial configuration 

  **/etc/redmine/default/mail2ticket.yml**

with very simple structure:

    production:
      project_name:
        method: imap
        host: mail.domain.exp
        password: secret123
        username: username
      project2_name:
        method: imap
        host: mx.domain.exp
        password: secret321
        username: username

    development:
      project3_name:
        method: pop
        host: pop3.demo.exp
        password: h1dden
        username: username

    etc ...


/etc/cron.d/ rule every 5 min run /usr/share/redmine/extra/mail_handler/mail2ticket.rb
which read records from configuration and feed it rake task. More info: 
http://www.redmine.org/projects/redmine/wiki/RedmineReceivingEmails

