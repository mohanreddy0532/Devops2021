#Redirect out put and Errors

#STDOUT 1> (>)
#STDERR 2>
#Both output and error &>
#Append &>>

ls -ld abc.txt >/tmp/output 2>/tmp/err
ls -ld abc.txt &>/tmp/both

ls &>/dev/null #Null file redirection

#Redirect Inputs
To show db without login to mongo
$echo 'show dbs;' | mongo
#vi /tmp/mongo
show dbs;
show collections;
mongo < /tmp/mongo



