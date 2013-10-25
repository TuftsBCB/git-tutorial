This document contains a walkthrough of basic git usage with GitHub. Each 
command used is explained.


Your first time with git
------------------------
If you've never used `git` before, then make sure it's installed and run the 
following commands so that your name and email will show up with your commits:

    $ git config --global user.name "Full Name"
    $ git config --global user.email "You@Domain.com"


Creating a repository and basic commands
----------------------------------------
Let's initialize a fresh new repository that will contain a list of our 
favorite foods in a directory of our choosing:

    $ mkdir foods
    $ cd foods
    $ git init

The `git init` command says, "initialize a new git repository in the current 
directory." The output of `git init` should look like this:

    Initialized empty Git repository in /home/andrew/tmp/foods/.git/

Now that the repository is created, we can use the `git status` command to 
inspect the status of our repository:

    $ git status
    # On branch master
    #
    # Initial commit
    #
    nothing to commit (create/copy files and use "git add" to track)

The directory is empty, so there is nothing to commit of course. In essence, 
"nothing to commit" means that the working set of files in your repository is 
equivalent to the latest changes recorded in your repository.

But if we make a change, like adding a file, then `git status` shows something 
different:

    $ touch andrew
    $ git status
    # On branch master
    #
    # Initial commit
    #
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       andrew
    nothing added to commit but untracked files present (use "git add" to track)

Now `git status` is telling us that there is an untracked file and its name is 
`andrew`. Since we'll want to record the history of modifications made to the 
file `andrew`, let's add the file to git's staging area:

    $ git add andrew

If we run `git status` again, we'll get something different:

    $ git status
    # On branch master
    #
    # Initial commit
    #
    # Changes to be committed:
    #   (use "git rm --cached <file>..." to unstage)
    #
    #       new file:   andrew

This says that the file we just added to the staging area is ready to be 
committed. This means that when we run the `git commit` command, the changes in
the files listed in the git staging area will be included in that commit.
Indeed, we can now commit our new file to this repository's database:

    $ git commit -m "A 'andrew' file with no favorite foods listed."
    [master (root-commit) b91e2c1] A 'andrew' file with no favorite foods listed.
     1 file changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 andrew

The `git commit` command in this case was used with the `-m` flag, which 
specifies a message to be attached to this commit. If you ran it without the 
`-m` flag, then git would automatically open up a text editor for you to type 
in your commit message. When you quit your editor, the commit will be saved.

Note that it is important to write meaningful commit messages. If you ever need 
to read the history of revisions in your repository, good commit messages will 
be invaluable. More importantly, they will make it easier for others to 
navigate your code history.

After the commit, if we run `git status`, then you'll see that once again, your 
working set of files is in sync with the latest changes recorded in your 
repository:

    $ git status
    # On branch master
    nothing to commit, working directory clean

Let's add some of our favorite foods to the file and repeat the process above:

    $ vim andrew
    $ cat andrew
    Buffalo chicken
    Cheeseburger
    Pizza
    $ git status
    # On branch master
    # Changes not staged for commit:
    #   (use "git add <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working direct
    #
    #       modified:   andrew
    #
    no changes added to commit (use "git add" and/or "git commit -a")
    $ git add andrew
    $ git commit -m "Added some of my favorite foods."
    [master 31c5f4d] Added some of my favorite foods.
     1 file changed, 3 insertions(+)
    $ git status
    # On branch master
    nothing to commit, working directory clean

As you use git more, this process will become very familiar: make changes, add 
changes to the staging area, and then commit the changes in the staging area to 
your repository.

