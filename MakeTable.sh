#!/bin/sh
cd /home/koizumi/kimura/chat
rails g model NewBoard${1} content:text user_id:integer imagename:string
rails db:migrate
