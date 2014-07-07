Git 学习笔记以及命令速查
====

初始化一个Git仓库，使用git init命令。

添加文件到Git仓库，分两步：

第一步，使用命令git add ，注意，可反复多次使用，添加多个文件；
第二步，使用命令git commit，完成。


命令*git rm*用于删除一个文件。如果一个文件已经被提交到版本库，那么你永远不用担心误删，但是要小心，你只能恢复文件到最新版本，你会丢失**最近一次提交后你修改的内容**。


要克隆一个仓库，首先必须知道仓库的地址，然后使用*git clone*命令克隆。

Git支持多种协议，包括https，但通过ssh支持的原生git协议速度最快。

Git鼓励大量使用分支：

查看分支：git branch

创建分支：git branch name

切换分支：git checkout name

创建+切换分支：git checkout -b name

合并某分支到当前分支：git merge name

删除分支：git branch -d name

当Git无法自动合并分支时，就必须首先解决冲突。解决冲突后，再提交，合并完成。

用*git log --graph*命令可以看到分支合并图。

Git分支十分强大，在团队开发中应该充分应用。

合并分支时，加上*--no-ff*参数就可以用普通模式合并，合并后的历史有分支，能看出来曾经做过合并，而*fast forward*合并就看不出来曾经做过合并。

修复bug时，我们会通过创建新的bug分支进行修复，然后合并，最后删除；

开发一个新feature，最好新建一个分支；

如果要丢弃一个没有被合并过的分支，可以通过*git branch -D name*强行删除。

当手头工作没有完成时，先把工作现场*git stash*一下，然后去修复bug，修复后，再*git stash pop*，回到工作现场。

查看远程库信息，使用*git remote -v*；
本地新建的分支如果不推送到远程，对其他人就是不可见的；
从本地推送分支，使用*git push origin branch-name*，如果推送失败，先用*git pull*抓取远程的新提交；
在本地创建和远程分支对应的分支，使用*git checkout -b branch-name origin/branch-name*，本地和远程分支的名称最好一致；
建立本地分支和远程分支的关联，使用*git branch --set-upstream branch-name origin/branch-name*；
从远程抓取分支，使用*git pull*，如果有冲突，要先处理冲突。

命令*git tag name*用于新建一个标签，默认为HEAD，也可以指定一个commit id；
-a tagname -m "blablabla..."可以指定标签信息；
-s tagname -m "blablabla..."可以用PGP签名标签；
命令*git tag*可以查看所有标签；

命令*git push origin tagname*可以推送一个本地标签；
命令*git push origin --tags*可以推送全部未推送过的本地标签；
命令*git tag -d tagname*可以删除一个本地标签；
命令*git push origin :refs/tags/tagname*可以删除一个远程标签。

忽略某些文件时，需要编写*.gitignore*。
.gitignore文件本身要放到版本库里，并且可以对*.gitignore*做版本管理！

给Git配置好别名，就可以输入命令时偷个懒。我们鼓励偷懒。


