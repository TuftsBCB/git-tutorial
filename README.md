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


Sharing your favorite foods on GitHub
-------------------------------------
Now that you know how to commit changes to your git repository, it's time to
share those changes with others. We'll do this by teaching your local
repository about a remote repository (on GitHub):

    $ git remote add github https://github.com/TuftsBCB/foods

(Note: Make sure that the repository https://github.com/TuftsBCB/foods exists.
If not, create a repository on your own account, and replace `TuftsBCB` with
your GitHub username.)

The `git remote add` command takes two arguments: a name of your choosing and a
remote location of a git repository. In this case, the
`https://github.com/TuftsBCB/foods` syntax indicates HTTPS. Typically, using
SSH is more convenient since you can use your public key to login
automatically. For SSH, you can use `git@github.com:TuftsBCB/foods` instead.

Indeed, let's try and push your food list to GitHub. You'll need to enter your
username and password:

    $ git push github master
    Username for 'https://github.com': BurntSushi
    Password for 'https://BurntSushi@github.com':
    Counting objects: 6, done.
    Delta compression using up to 4 threads.
    Compressing objects: 100% (2/2), done.
    Writing objects: 100% (6/6), 497 bytes | 0 bytes/s, done.
    Total 6 (delta 0), reused 0 (delta 0)
    To https://github.com/BurntSushi/foods
     * [new branch]      master -> master

(Protip: Add your SSH public key to your GitHub account if you don't want
to enter your username and password every time you push:
https://github.com/settings/ssh)

You should now be able to go to https://github.com/TuftsBCB/foods and see your
changes show up.

The `git push` command here takes two arguments: the name of the remote (which
we added with `git remote add`) and the name of the branch to push. Since we
haven't made any new branches yet, we use the default branch which is always
named `master`.


Pulling changes from GitHub to your local repository
----------------------------------------------------
Next time you come back to work on your code, you'll want to make sure your
local repository is in sync with your GitHub repository (particularly if you're
working with others). You can do this by pulling changes from GitHub into your
`master` branch:

    $ git pull github master
    remote: Counting objects: 4, done.
    remote: Compressing objects: 100% (2/2), done.
    remote: Total 3 (delta 0), reused 0 (delta 0)
    Unpacking objects: 100% (3/3), done.
    From https://github.com/BurntSushi/foods
     * branch            master     -> FETCH_HEAD
       31c5f4d..eac39e6  master     -> github/master
    Updating 31c5f4d..eac39e6
    Fast-forward
     README.md | 4 ++++
     1 file changed, 4 insertions(+)
     create mode 100644 README.md

In my case, someone added a `README.md` file and pushed it to GitHub. That
README is now in my repository.

The command we ran, `git pull`, is the dual of `git push`. It also takes two
arguments: the first is the name of the remote and the second is the name of
the branch we want to merge.


Using Tufts instead of GitHub
-----------------------------
If you don't want to share your code on GitHub, you can also host a git
repository on one of our Tufts servers. In order for it to be like GitHub, it
will have to be a *bare* repository, which is a repository that only contains a
git database and no working set of files. (Therefore, it is a repository
suitable to be shared between multiple users.)

In our environment, by convention, we put all bare repositories in
`/r/bcb/repositories`. To make your own:

    $ cd /r/bcb/repositories
    $ mkdir foods
    $ cd foods
    $ git init --bare --shared=group

The last command is similar to what you ran when you made your `foods`
repository in the beginning of this walkthrough. However, we've added two
switches: `--bare` and `--shared=group`. The first tells git to make this a
bare repository. The second makes sure the permissions are set correctly so
that anyone in the `bcb` group can push and pull to the repository.

The repository can now be used just like you'd use a GitHub repository. You can
add a remote using SSH urls:

    $ git remote add tufts {utln}@linux.cs.tufts.edu:/r/bcb/repositories/foods

Where `{utln}` is your UNIX login account name. If you get an authentication
error, make sure your SSH keys are set up correctly.


Merge conflicts
---------------
When two or more people are working on a code base, the chances of a merge
conflict go up. Happily, git can avoid merge conflicts even if two or more
people make changes to the same file by merging the changes. But if there are
changes made to the same part of the file, git will not be able to reconcile
the differences and will force you to manually intervene and fix the conflict.

More specifically, a merge conflict occurs when you merge changes into your
repository that affect changes you've committed since last merging.

Let's forcefully create a merge conflict so you can see how to deal with them.
First, in your `foods` repository, change the *first* line to a different food.
Then commit the change to your repository, but *do not* push it:

    $ vim andrew
    $ cat andrew
    Fries
    Cheeseburger
    Pizza
    $ git add andrew
    $ git commit -m "I like fries too."
    [master f21c9c3] I like fries too.
     1 file changed, 1 insertion(+), 1 deletion(-)

In order to provoke a merge conflict, we now need to make some changes to the
GitHub repository, push them and try to pull them. In order to do that, let's
create a new clone of the `foods` repository temporarily:

    $ cd ..
    $ git clone https://github.com/BurntSushi/foods foods-tmp
    Cloning into 'foods-tmp'...
    remote: Counting objects: 9, done.
    remote: Compressing objects: 100% (4/4), done.
    remote: Total 9 (delta 0), reused 6 (delta 0)
    Unpacking objects: 100% (9/9), done.
    Checking connectivity... done
    $ cd foods-tmp/
    $ cat andrew
    Buffalo chicken
    Cheeseburger
    Pizza

Notice that my first favorite food is still `Buffalo Chicken` and not `Fries`.
This is because we haven't pushed our last commit. Also, this is the first time
we've used the `git clone` command, which copies an existing repository. The
first argument is either another directory or a remote url identifying the
repository. The second (optional) argument names the directory that will
contain the repository.

Let's continue trying to provoke a merge conflict by changing the first line
again, but to something other than what you changed it to before. Then commit
your change, and this time, push your changes to github:

    $ vim andrew
    $ cat andrew
    Hot dog
    Cheeseburger
    Pizza
    $ git add andrew
    $ git commit -m "I also like hot dogs."
    [master bb9954b] I also like hot dogs.
     1 file changed, 1 insertion(+), 1 deletion(-)

Now push your changes to GitHub. (Since this is a new repository, we'll need to
add the GitHub remote information again.)

    $ git remote add github https://github.com/BurntSushi/foods
    $ git push github master
    Username for 'https://github.com': BurntSushi
    Password for 'https://BurntSushi@github.com':
    Counting objects: 5, done.
    Delta compression using up to 4 threads.
    Compressing objects: 100% (2/2), done.
    Writing objects: 100% (3/3), 311 bytes | 0 bytes/s, done.
    Total 3 (delta 0), reused 0 (delta 0)
    To https://github.com/BurntSushi/foods
       eac39e6..bb9954b  master -> master

Finally, let's get the merge conflict by pulling from GitHub in our original
`foods` repository:

    $ cd ../foods
    $ git pull github master
    remote: Counting objects: 5, done.
    remote: Compressing objects: 100% (2/2), done.
    remote: Total 3 (delta 0), reused 3 (delta 0)
    Unpacking objects: 100% (3/3), done.
    From https://github.com/BurntSushi/foods
     * branch            master     -> FETCH_HEAD
       eac39e6..bb9954b  master     -> github/master
    Auto-merging andrew
    CONFLICT (content): Merge conflict in andrew
    Automatic merge failed; fix conflicts and then commit the result.

Git kindly informs you that it was unable to resolve the differences between
the commit added to GitHub and the commit you made to your local repository.
When this happens, git will add both versions in the file in which the conflict
occurred. Indeed, if we look at the contents of `andrew`, we'll see exactly
where the conflict is:

    $ cat andrew
    <<<<<<< HEAD
    Fries
    =======
    Hot dog
    >>>>>>> bb9954be67d8a846cfc4c4abb5607649ccc0a329
    Cheeseburger
    Pizza

The `HEAD` portion indicates the version in your local repository, while the
second portion indicates the version that exists in GitHub (along with an
identifier for the specific commit).

We are now free to merge this conflict however we deem suitable. When we're
done, we'll need to remove the lines containing `<<<...`, `===...` and
`>>>...`, or else git won't let us commit it.

Since I like both fries and hot dogs, let's keep both:

    $ vim andrew
    $ cat andrew
    Fries
    Hot dog
    Cheeseburger
    Pizza
    $ git add andrew
    $ git commit -m "I like both."
    [master 68a3c6a] I like both.
    $ git push github master
    Username for 'https://github.com': BurntSushi
    Password for 'https://BurntSushi@github.com':
    Counting objects: 10, done.
    Delta compression using up to 4 threads.
    Compressing objects: 100% (4/4), done.
    Writing objects: 100% (6/6), 614 bytes | 0 bytes/s, done.
    Total 6 (delta 0), reused 0 (delta 0)
    To https://github.com/BurntSushi/foods
       bb9954b..68a3c6a  master -> master

Once you've made the change, commit it to your repository and push the changes 
back to GitHub. (If you wanted, you could go back to your `foods-tmp` 
repository and pull the new changes from GitHub without any merge conflicts.)

