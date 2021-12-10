#Redirect out put and Errors

#STDOUT 1> (>)
#STDERR 2>
#Both output and error &>
#Append &>>

ls -ld abc.txt >/tmp/output 2>/tmp/err
ls -ld abc.txt &>/tmp/both