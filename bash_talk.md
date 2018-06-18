% Beginning Bash
% Tony Williams
% X World 2018

### Getting A Terminal App

 - iTerm2

<div class="notes">
This year I'm going to teach this workshop a little differently than I did two years ago. I'm going to concentrate less on syntax and  more on examples and regular expressions.

Before we get on to the shell I'd like to say a few words about the Terminal app. Number one is don't use it. Use iTerm2 instead.
</div>

### Setting Preferences

<div class="notes">
The second is to get away from historical absurdities. Back when I started programming we used physical terminals that produced only 80 characters by 24 lines on a 12 or 14 inch monitor. We can give that up, there's no need to emulate that in 2018. Set your default window size to something more sensible and also a larger font. I use 110 characters by 40 lines and an 18pt font for these old eyes.
</div>

### Install Homebrew

<div class="notes">
So step number one in getting the shell working right is installing homebrew. Then you can use homebrew to install a few necessities. I'd number bash completion the top of that list.

By the way, after you install bash completion there are a number of extensions for Apple command line tools that I've written. You can get them at my github page.
</div>

### Variables
``` bash
WORD="Foobar"
echo $WORD
```
<div class="notes">
Open up your terminal and give that a try. Here we set the bash variable WORD.
</div>

###
``` bash
WORD="Foobar" ; echo $WORD
```

<div class="notes">
Notice the semi colon - we use that to separate two commands on the one line.
</div>

### Using A Command

``` bash
id -un
username=`id -un`
echo $username
unset username
echo $username
username=$(id -un)
echo $username
```

<div class="notes">
You can also set a variable to the output of a command. Follow along with
me here <DEMO>
</div>

### Special variables

```
export CDPATH=".:~:~/Library:~/Dropbox:~/dev:~/Documents"
```
<div class="notes">
bash has a number of special variables. We can set them so that life is easier. One of my favourites is CDPATH
</div>

### Aliases

``` bash
LS_OPTIONS="--color=auto -F -G"
# standard ls coloured
alias ls='gls $LS_OPTIONS'
# standard plus dot files
alias la='gls $LS_OPTIONS -A'

alias profile='bbedit -b ~/.bash_profile'
alias flushDNS='dscacheutil -flushcache'
```
<div class="notes">
In your bash profile you can start a little bash programming. The simplest bash programming is aliases. We use aliases for providing common or hard to remember options for commands. Here's a couple of examples.
</div>


### Functions

``` bash
# function to send man page to preview
manp()
{
	man -t $* | open -f -a /Applications/Preview.app/
}
```
<div class="notes">
Now with aliases the variable part for it must be at the end. If we want something different we have to use a function. Here's a useful function.


I have included a copy of my bash profile so you can see what other possibilities there are.

Now let's move on to the simple end of bash syntax. This one is also from my bash profile.
</div>

### Example Decision
``` bash
# make root red
if [ `id -u` = 0 ]
then
        PS1="\[\033[31m\]\h:\W \u\$\[\033[0m\] "
fi
```

<div class="notes">
An if statement. In this one we decide if we want to change the colour
of the prompt depending if we are `root` or not. Note the `id -u`
between the backticks. When we place a command between backticks the
command is run and the output is used. Here we have the `id` shell
command print our user ID, which is 0 if we are root.
</div>

### Checking The Result Code
``` bash
if ls mysillyfilename ; then
    echo "File exists."
fi

# checking result code variable
ls mysillyfilename
if [ $? = 0 ] ; then
    echo "File exists."
fi
```

<div class="notes">
We can use the result from any command in an `if` statement. The
special variable `$?` saves the result of the last command.
</div>

### Checking A File
```bash
if [ -e README.md ] ; then
	echo "Readme exists"
fi
```

<div class="notes">
We can also test files, their existence and type. Here we use `-e` to
test that the file exists.
</div>

### File Checks

|    |                      |    |                       |
|:--:|:---------------------|:--:|:----------------------|
| -a | if file exists       | -d | if file is directory  |
| -e | if file exists       | -r | if file is readable   |
| -w | if file is writeable | -x | if file is executable |
| -O | is owned by the user | -G | is owned by the group |

<div class="notes">
Here is a list of some of the more useful file tests. `man test` will
get you a comprehensive list and a list of all the comparison
operators for strings and numbers
</div>

### Round And Round
- For
- While
- Done

### While Loop
``` bash
#!/bin/bash
WORD="Start"
while [ "$WORD" != "" ] ; do
echo -n "Word: " ; read WORD
    case "$WORD" in
        ( "Foo" )       echo "Bar" ;;
        ( "Bar" )       echo "Foo" ;;
        ( "FooBar" )    echo "No Way" ;;
        ( "" ) ;;
        ( * )           echo "FooBar" ;;
    esac
done
```

<div class="notes">
A while loop. So long as the statement is true it will loop forever.
In `while.sh`.
</div>

### For Ever
``` bash
for file in *.sh ; do
    echo $file
done
```

<div class="notes">
A for loop. The echo statement will run for each item in `*.sh`.
In `for.sh`.
</div>

### Expanding Variables
``` bash
LIST="Foo Bar Baz"
for i in $LIST ; do
	echo $i
done
```

<div class="notes">
We can also loop through items in a variable.
</div>

### Field Separator
``` bash
IFS=":"
LIST="a:b:c d"
for i in $LIST ; do
    echo $i
done
```

<div class="notes">
What defines an "item" is the Internal Field Seperator or IFS. Here we
change it to a colon. In `expand.sh`.
</div>

### Redirection

### How It's Done
- Fresh output
`ls > files.txt`
- Append to the file
`ls >> files.txt`

<div class="notes">
We can take the output of a command and redirect it to a file. A
single greater than will overwrite an existing file, two will append
to the end of an existing file. Both will create the file if it
doesn't exist.
</div>

### Using tee
- Fresh file
`ls | tee files.txt`
- Append to the file
`ls | tee -a files.txt`

<div class="notes">
`tee` allows us to redirect the output to a file _and_ see it in the terminal.
</div>

### Both OUT and ERR
If you want to log to the same file:
`command1 >> log_file 2>&1`

If you want different files:
`command1 >> log_file 2>> err_file`
<div class="notes">
There are actually *two* outputs. The "ordinary" one, STDOUT and one
for errors, STDERR. They are numbered 1 and 2 respectively and we can
direct them both if we want.
</div>

### Maths Using `expr`
``` bash
#!/bin/bash

WEEKS=$1
DAYS=`expr $WEEKS '*' '7'`
date -v +${DAYS}d
```

<div class="notes">
We can do maths in scripts using the `expr` command. In `weeks.sh`.
</div>

### Maths Using Expansion
``` bash
#!/bin/bash

WEEKS=$1
DAYS=$(($WEEKS*7))
date -v +${DAYS}d
```
Or even
`echo $(( 7 * ( 4 + 2 ) ))`
Though the spaces are not required `echo $((7*(4+2)))`

<div class="notes">
It often looks clearer to use shell arithmetic expansion for maths.
</div>

### Improve The Look
``` bash
WEEKS=$1
DAYS=`expr $WEEKS '*' '7'`
date -v +${DAYS}d | awk '{ print $1 " " $2 " " $3 " " $4 }'
```

<div class="notes">
We can pipe the output of the `date` command to a utility called
`awk`. This is a powerful text processing language but here we just
use a simple command. This one just prints some of the fields. Awk is
often used to trim or reformat the output of another command.
In `weeks2.sh`.
</div>

### Looking At Some Examples

<div class="notes">
Here I will go through some examples from simple shell scripts that I have written at work. They contain no Suncorp data or passwords.
</div>



