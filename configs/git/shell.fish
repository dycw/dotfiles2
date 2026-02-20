#!/usr/bin/env fish

if not status is-interactive; or not type -q git
    exit
end

#### config ###################################################################

function edit-git-shell
    $EDITOR $PATH_DOTFILES/configs/git/shell.fish
end

#### git ######################################################################

# add

function ga
    __git_add $argv
end

function gaf
    __git_add $argv --force
end

function gap
    git add --all --patch $argv
end

function __git_add
    argparse force -- $argv; or return $status
    set -l args
    if test (count $argv) -eq 0
        set args $args --all
    else
        set args $args $argv
    end
    if test -n "$_flag_force"
        set args $args --force
    end
    git add $args
end

# branch

function gb
    git branch-default
end

function gbd
    if test (count $argv) -eq 0
        __git_branch_fzf_local --multi | while read branch
            git branch-delete $branch
        end
    else
        for branch in $argv
            git branch-delete $branch
        end
    end
end

function gbdr
    git fetch-default; or return $status
    if test (count $argv) -eq 0
        __git_branch_fzf_remote --multi | xargs -r -I{} git push --delete origin "{}"
    else
        git push --delete origin $argv
    end
end

function gbm
    if test (count $argv) -eq 0
        echo "'gbm' expected [1..) arguments BRANCH; got $(count $argv)" >&2; and return 1
    end
    git branch -m $argv
end

function __git_branch_fzf_local
    argparse multi -- $argv; or return $status
    set -l args
    if test -n "$_flag_multi"
        set args $args --multi
    end
    git branch --format='%(refname:short)' | fzf $args
end

function __git_branch_fzf_remote
    argparse multi -- $argv; or return $status
    set -l args
    if test -n "$_flag_multi"
        set args $args --multi
    end
    git branch --color=never --remotes | awk '!/- >/' | fzf $args \
        | sed -E 's|^[[:space:]]*origin/||'
end

function __git_branch_purge_local
    git branch -vv | awk '/: gone]/{print $1}' | xargs -r git branch -D
end

# checkout

function gcb
    set -l args
    if test (count $argv) -eq 0
    else if test (count $argv) -eq 1
        set args $args --title $argv[1]
    else if test (count $argv) -eq 2
        set args $args --title $argv[1] --num $argv[2]
    else if test (count $argv) -eq 3
        set args $args --title $argv[1] --num $argv[2] --part
    else
        echo "'gcb' expected [0..3] arguments TITLE NUM PART; got $(count $argv)" >&2; and return 1
    end
    __git_checkout_open $args
end

function gcbr
    set -l branch
    if test (count $argv) -eq 0
        set branch (__git_branch_fzf_remote)
    else if test (count $argv) -eq 1
        set branch $argv[1]
    else
        echo "'gcbr' expected [0..1] arguments BRANCH; got "(count $argv) >&2; and return 1
    end
    git checkout -b $branch -t origin/$branch
end

function gco
    set -l branch
    if test (count $argv) -eq 0
        set branch (__git_branch_fzf_local)
    else
        set branch $argv[1]
    end
    git checkout $branch
end

function gcof
    if test (count $argv) -eq 0
        git checkout -- .
    else
        if git is-valid-ref $argv[1]
            git fetch-default; or return $status
            git checkout $argv[1] -- $argv[2..]
        else
            git checkout -- $argv
        end
    end
end

function gcfm
    git fetch-default; or return $status
    set -l branch (git default-remote-branch); or return $status
    git checkout $branch -- $argv
end

function gm
    set -l branch (git default-local-branch); or return $status
    __git_checkout_close $branch
end
function gmd
    set -l branch (git default-local-branch); or return $status
    __git_checkout_close $branch --delete
end
function gmx
    set -l branch (git default-local-branch); or return $status
    __git_checkout_close $branch --delete --exit
end

function __git_checkout_open
    argparse title= num= part -- $argv; or return $status
    git fetch-default; or return $status
    set -l branch
    if test -z "$_flag_title"; and test -z "$_flag_num"
        set branch dev
    else if test -n "$_flag_title"; and test -z "$_flag_num"
        set branch (__clean_branch_name $_flag_title); or return $status
    else if test -z "$_flag_title"; and test -n "$_flag_num"
        set branch $_flag_num
    else
        set branch "$_flag_num-$(__clean_branch_name $_flag_title)"; or return $status
    end
    git checkout -b $branch $(git default-remote-branch); or return $status
    git commit --allow-empty --message="$(__auto_msg)" --no-verify; or return $status
    __git_push --no-verify; or return $status
    set -l title
    if test -n "$_flag_title"
        set title $_flag_title
    else
        set title (__auto_msg); or return $status
    end
    set -l args
    if test -n "$_flag_num"
        if test -n "$_flag_part"
            set args $args "Part of $_flag_num"
        else
            set args $args "Closes $_flag_num"
        end
    end
    __git_create --title $title $args
end

function __git_checkout_close
    if test (count $argv) -eq 0
        echo "'__git_checkout_close' expected [1..) arguments TARGET; got $(count $argv)" >&2; and return 1
    end
    argparse delete delete-remote exit -- $argv; or return $status
    set -l target $argv[1]
    set -l original (git current-branch); or return $status
    git checkout $target; or return $status
    git pull-default; or return $status
    if test -n "$_flag_delete"
        git branch-delete $original
    end
    if test -n "$_flag_delete_remote"
        git branch-delete-remote $original
    end
    if test -n "$_flag_exit"
        exit
    end
end

# cherry-pick

function gcp
    git cherry-pick $argv
end

# clone

function gcl
    if test (count $argv) -eq 0
        echo "'gcl' expected [1..2) arguments REPO DIR; got $(count $argv)" >&2; and return 1
    end
    set -l args
    if test (count $argv) -ge 2
        set args $args --dir $argv[2]
    end
    __git_clone --repo $argv[1] $args
end

function __git_clone
    argparse repo= dir= -- $argv; or return $status
    set -l dir
    if test -n "$_flag_dir"
        set dir $_flag_dir
    else
        set dir (basename (string replace -r '\.git$' '' -- $_flag_repo))
    end
    git clone --recurse-submodules $_flag_repo $dir; or return $status
    set -l current (pwd)
    cd $dir
    if type -q prek
        prek install; or return $status
    end
    if type -q direnv
        if test -f .env; or test -f .envrc
            direnv allow .
        end
    end
    cd $current
end

# commit + push

function gc
    __git_commit_push
end
function gcn
    __git_commit_push --no-verify
end
function gcf
    __git_commit_push --force
end
function gcnf
    __git_commit_push --no-verify --force
end
function gcw
    __git_commit_push --web
end
function gcnw
    __git_commit_push --no-verify --web
end
function gcfw
    __git_commit_push --force --web
end
function gcnfw
    __git_commit_push --no-verify --force --web
end
function gce
    __git_commit_push --exit
end
function gcne
    __git_commit_push --no-verify --exit
end
function gcfe
    __git_commit_push --force --exit
end
function gcnfe
    __git_commit_push --no-verify --force --exit
end
function gcx
    __git_commit_push --web --exit
end
function gcnx
    __git_commit_push --no-verify --web --exit
end
function gcfx
    __git_commit_push --force --web --exit
end
function gcnfx
    __git_commit_push --no-verify --force --web --exit
end

function __git_commit_push
    if git is-clean
        return 0
    end
    argparse no-verify force web exit -- $argv; or return $status
    set -l commit_args
    if test $_flag_no_verify
        set commit_args $commit_args --no-verify
    end
    git commit --message=$(__auto_msg) $commit_args; or return $status
    set -l push_args
    if test $_flag_force
        set push_args $push_args --force
    end
    if test $_flag_no_verify
        set push_args $push_args --no-verify
    end
    if test $_flag_web
        set push_args $push_args --web
    end
    if test $_flag_exit
        set push_args $push_args --exit
    end
    __git_push $push_args
end

function __git_commit_until_push
    argparse no-verify force web exit -- $argv; or return $status
    set -l commit_args
    if test -n "$_flag_no_verify"
        set commit_args $commit_args --no-verify
    end
    set -l proceed 0
    for i in (seq 1 3)
        if test $proceed -eq 0
            ga $argv; or return $status
            __git_commit_push $commit_args
            if test $status -eq 0; and git is-clean
                set proceed 1
            end
        end
    end
    if test $proceed -eq 0
        echo "'__git_commit_until_push' failed after $i attempts" >&2; and return 1
    end
    set -l push_args
    if test $_flag_force
        set push_args $push_args --force
    end
    if test $_flag_no_verify
        set push_args $push_args --no-verify
    end
    if test $_flag_web
        set push_args $push_args --web
    end
    if test $_flag_exit
        set push_args $push_args --exit
    end
    __git_push $push_args
end

# diff

function gd
    git diff $argv
end
function gdc
    git diff --cached $argv
end
function gdm
    if test (count $argv) -ge 1
        git diff (git default-remote-branch) -- $argv
    else
        git diff (git default-remote-branch)
    end
end

# fetch

function gf
    git fetch-default
end

# log

function gl
    set -l args
    if test (count $argv) -eq 0
        set args $args -n 20
    else if string match -qr '^[0-9]+$' -- $argv[1]; and test $argv[1] -ge 1
        set args $args -n $argv[1]
    end
    git log-default $args
end

# mv

function gmv
    git mv $argv
end

# pull

function gpl
    git pull-default $argv
end

# push

function gp
    __git_push
end
function gpn
    __git_push --no-verify
end
function gpf
    __git_push --force
end
function gpfn
    __git_push --force --no-verify
end
function gpw
    __git_push --web
end
function gpnw
    __git_push --no-verify --web
end
function gpfw
    __git_push --force --web
end
function gpfnw
    __git_push --force --no-verify --web
end
function gpe
    __git_push --exit
end
function gpne
    __git_push --no-verify --exit
end
function gpfe
    __git_push --force --exit
end
function gpfne
    __git_push --force --no-verify --exit
end
function gpx
    __git_push --web --exit
end
function gpnx
    __git_push --no-verify --web --exit
end
function gpfx
    __git_push --force --web --exit
end
function gpfnx
    __git_push --force --no-verify --web --exit
end

function __git_push
    argparse force no-verify web exit -- $argv; or return $status
    set -l args
    if test -n "$_flag_force"
        set args $args --force
    end
    set args $args --set-upstream origin (git current-branch); or return $status
    if test -n "$_flag_no_verify"
        set args $args --no-verify
    end
    git push $args; or return $status
    if test -n "$_flag_web"
        __git_view; or return $status
    end
    if test -n "$_flag_exit"
        exit
    end
end

# rebase

function grb
    __git_rebase
end
function grbp
    __git_rebase --push
end
function grbw
    __git_rebase --push --web
end

function __git_rebase
    argparse push web -- $argv; or return $status
    git fetch-default; or return $status
    set -l branch (git default-remote-branch); or return $status
    git rebase --strategy=recursive --strategy-option=theirs $branch; or return $status
    if test -n "$_flag_push"
        prek run --all-files
        set -l args
        if test -n "$_flag_web"
            set args $args --web
        end
        __git_all --no-verify --force $args
    end
end

function grba
    git rebase --abort $argv
end
function grbc
    git rebase --continue $argv
end
function grbs
    git rebase --skip $argv
end

# remote

function add-remote
    if test (count $argv) -le 1
        echo "'add-remote' expected [2..) arguments NAME URL; got $(count $argv)" >&2; and return 1
    end
    git remote add $argv
    git remote set-url --push $argv
end

function remove-remote
    if test (count $argv) -eq 0
        echo "'remove-remote' expected [1..) arguments NAME; got $(count $argv)" >&2; and return 1
    end
    git remote remove $argv
end

function set-remote
    if test (count $argv) -le 1
        echo "'set-remote' expected [2..) arguments NAME URL; got $(count $argv)" >&2; and return 1
    end
    git remote set-url $argv; or return $status
    git remote set-url --push $argv
end

function grem
    git remote -v
end

function __remote_is
    if test (count $argv) -eq 0
        echo "'__remote_is' expected [1..) arguments REMOTE; got $(count $argv)" >&2; and return 1
    end
    if git remote-name | grep -q $argv[1]
        return 0
    else
        return 1
    end
end

function __remote_is_github
    __remote_is github
end
function __remote_is_gitlab
    __remote_is gitlab
end
function __remote_is_gitea
    __remote_is gitea or __remote_is ts.net
end

# reset

function gr
    git reset $argv
end

function grhom
    set -l branch (git default-remote-branch); or return $status
    git reset --hard $branch $argv
end

function grp
    git reset --patch $argv
end

function gsq
    git fetch-default; or return $status
    set -l branch (git default-remote-branch); or return $status
    git reset --soft $(git merge-base $branch HEAD)
end

# restore

function gres
    git restore $argv
end

function gun
    git restore --staged $argv
end

# rev-parse

function cdr
    cd (git repo-root)
end

# rm

function grm
    __git_rm $argv
end
function grmc
    __git_rm $argv --cached
end

function __git_rm
    argparse cached -- $argv; or return $status
    set -l args
    if test -n "$_flag_cached"
        set args $args --cached
    end
    git rm -rf $argv
end

# switch

function gsw
    __git_switch $argv
end
function gswc
    if test (count $argv) -eq 0
        echo "'gswc' expected [1..) arguments BRANCH; got $(count $argv)" >&2; and return 1
    end
    __git_switch --create=$argv[1] $argv[2..]
end

function __git_switch
    argparse create= -- $argv; or return $status
    set -l args
    if test -n "$_flag_create"
        set args $args --create="$_flag_create"
    end
    git switch $args $argv
end

# stash

function gst
    git stash $argv
end

function gstd
    git stash drop $argv
end

function gstp
    git stash pop $argv
end

# status

function gs
    git status $argv
end

function wg
    watch --color --interval 2 --no-title --no-wrap -- '
        echo "==== status ==================================================================="
        git -c color.ui=always status --short
        if ! git diff --quiet; then
            printf "\n==== diff =====================================================================\n"
            git -c color.ui=always diff --stat
        fi
        branch=$(printf "%-6s" "$(git default-local-branch)")
        if ! git diff-remote --quiet; then
            printf "\n==== diff origin/$branch =======================================================\n"
            git -c color.ui=always diff-remote --stat
        fi
        if (git remote-name | grep -q github) && (command -v gh >/dev/null 2>&1); then
            printf "\n==== github ==================================================================="
            gh pr status
        fi
    '
end

# submodule

function gsa
    git submodule add $argv
end
function gsu
    git submodule-update
end

# tag

function gta
    if test (count $argv) -eq 0
        if type -q bump-my-version
            git tag-add (bump-my-version show current_version) HEAD
        else
            echo "'gta' expected 'bump-my-version' to be available" >&2; and return 1
        end
    else if test (count $argv) -eq 1
        git tag-add $argv[1] HEAD
    else if test (math (count $argv) % 2) -eq 0
        while test (count $argv) -ge 2
            git tag-add $argv[1..2]
            set argv $argv[3..-1]
        end
    else
        echo "'gta' expected 0, 1 or an even number of arguments; got $(count $argv)" >&2; and return 1
    end
end

function gtd
    git tag-delete $argv
end

function __git_tag_push
    if test (count $argv) -le 1
        echo "'__git_tag_push' expected [2..) arguments TAG SHA; got $(count $argv)" >&2; and return 1
    end
    set -l tag $argv[1]
    set -l sha $argv[2]
    git tag -a "$tag" "$sha" -m "$tag"; or return $status
    git push --tags --force --set-upstream origin; or return $status
end

#### github ###################################################################

function __github_create
    argparse title= body= -- $argv; or return $status
    set -l title
    if test -n "$_flag_title"
        set title $_flag_title
    else
        set title (__auto_msg); or return $status
    end
    set -l body
    if test -n "$_flag_body"
        set body $_flag_body
    else
        set body .
    end
    gh pr create --title $title --body $body
end

function __github_edit
    argparse title= body= -- $argv; or return $status
    set -l args
    if test -n "$_flag_title"
        set args $args --title $_flag_title
    end
    if test -n "$_flag_body"
        set args $args --body $_flag_body
    end
    gh pr edit $args
end

function __github_exists
    set -l branch (git current-branch); or return $status
    set -l num (gh pr list --head=$branch --json number --jq '. | length'); or return $status
    if test $num -eq 0
        return 1
    else if test $num -eq 1
        return 0
    else
        echo "'__github_exists' expected a unique PR for '$branch'; got $num" >&2; and return 1
    end
end

function __github_merge
    argparse exit -- $argv; or return $status
    set -l curr_branch (git current-branch); or return $status
    if not __github_exists
        echo "'__github_merge' could not find an open PR for '$curr_branch'" >&2; and return 1
    end
    set -l repo (git repo-name); or return $status
    set -l start (date +%s); or return $status
    set -l elapsed
    gh pr merge --auto --delete-branch --squash; or return $status
    while __github_merging
        set elapsed (math (date +%s) - $start)
        echo "$repo/$curr_branch is still merging... ($elapsed s)"
        sleep 1
    end
    set -l args
    if test -n "$_flag_exit"
        set args $args --exit
    end
    set -l def_branch (git default-local-branch); or return $status
    __git_checkout_close $def_branch --delete $args
end

function __github_merging
    set -l branch (git current-branch); or return $status
    set -l state (gh pr view --json state | jq -r .state); or return $status
    if test -z "$state" -o "$state" != OPEN
        return 1
    end
    set -l repo (gh repo view --json nameWithOwner -q .nameWithOwner)
    if gh api repos/$repo/branches/$branch >/dev/null
        return 0
    else
        return 1
    end
end

function __github_view
    if gh pr ready >/dev/null 2>&1
        gh pr view -w
    else if type -q gitweb
        gitweb
    else
        set -l branch (git current-branch); or return $status
        echo "'__github_view' could not find an open PR for '$branch', nor could it find 'gitweb'" >&2; and return 1
    end
end

#### gitlab ###################################################################

function __gitlab_create
    argparse title= description= -- $argv; or return $status
    set -l args
    if test -n "$_flag_title"
        set title $_flag_title
    else
        set title (__auto_msg); or return $status
    end
    if test -n "$_flag_description"
        set description $_flag_description
    else
        set description .
    end
    glab mr create --push --remove-source-branch --squash-before-merge $args --title $title --description $description
end

function __gitlab_merge
    argparse exit -- $argv; or return $status
    set -l repo (git repo-name); or return $status
    set -l curr_branch (git current-branch); or return $status
    set -l start (date +%s); or return $status
    set -l i 0
    while true
        set -l json (__gitlab_mr_json 2>&1)
        set -l json_status $status
        if test $i -eq 0; and test $json_status -eq 100
            echo "'__gitlab_merge' expected an MR for '$curr_branch'; got none" >&2; and return 1
        else if test $i -ge 1; and test $json_status -eq 100
            break
        else if test $json_status -eq 101
            echo "'__gitlab_merge' expected a unique MR for '$curr_branch'" >&2; and return 1
        else if test $json_status -ne 0
            echo "'__gitlab_merge' expected an exit status of 0, 100 or 101; got $json_status" >&2; and return 1
        end
        set -l state (echo $json | jq -r .state); or return $status
        if test $state != opened
            echo "'__gitlab_merge' expected the MR for '$curr_branch' to be opened; got '$state'" >&2; and return 1
        end
        set -l merge_status (__gitlab_mr_merge_status $json); or return $status
        if test "$merge_status" = conflict; or test "$merge_status" = need_rebase; or test "$merge_status" = 'not open'
            echo "'__gitlab_merge' cannot merge the MR for '$curr_branch' because of merge status '$merge_status'" >&2; and return 1
        end
        glab mr merge --remove-source-branch --squash --yes &>/dev/null
        set i (math $i+1)
        set -l json (__gitlab_mr_json 2>&1)
        if test $status -eq 100
            break
        end
        set -l merge_status (__gitlab_mr_merge_status $json); or return $status
        set -l elapsed (math (date +%s) - $start)
        echo "'$repo/$curr_branch' is still merging... ($i, $merge_status, $elapsed s)"
        sleep 1
    end
    set -l def_branch (git default-local-branch); or return $status
    set -l args
    if test -n "$_flag_exit"
        set args $args --exit
    end
    __git_checkout_close $def_branch --delete $args
end

function __gitlab_update
    argparse title= description= -- $argv; or return $status
    set -l args
    if test -n "$_flag_title"
        set args $args --title $_flag_title
    end
    if test -n "$_flag_body"
        set args $args --description $_flag_description
    end
    set -l num (__gitlab_mr_num); or return $status
    glab mr update $num $args
end

function __gitlab_mr_json
    set -l branch (git current-branch); or return $status
    set -l json (glab mr list --output=json --source-branch=$branch); or return $status
    set -l num (printf %s $json | jq length); or return $status
    if test $num -eq 0
        echo "'__gitlab_mr_json' expected an MR for '$branch'; got none" >&2; and return 100
    else if test $num -eq 1
        printf "%s\n" "$json" | jq .[0]
    else
        echo "'__gitlab_mr_json' expected a unique MR for '$branch'; got $num" >&2; and return 101
    end
end

function __gitlab_mr_merge_status
    if test (count $argv) -eq 0
        echo "'__gitlab_mr_merge_status' expected [1..) arguments JSON; got $(count $argv)" >&2; and return 1
    end
    echo (string collect $argv) | jq -r .detailed_merge_status
end

function __gitlab_mr_num
    if test (count $argv) -eq 0
        echo "'__gitlab_mr_num' expected [1..) arguments JSON; got $(count $argv)" >&2; and return 1
    end
    echo (string collect $argv) | jq -r .iid
end

function __gitlab_view
    set -l json (__gitlab_mr_json 2>&1)
    if test $status = 0
        set -l num (__gitlab_mr_num $json)
        glab mr view $num --web
    else if type -q gitweb
        gitweb
    else
        set -l branch $(git current-branch); or return $status
        echo "'__gitlab_view' could not find an open MR for '$branch', nor could it find 'gitweb'" >&2; and return 1
    end
end

#### gitea ####################################################################

function __gitea_create
    argparse title= description= -- $argv; or return $status
    set -l title
    if test -n "$_flag_title"
        set title $_flag_title
    else
        set title (__auto_msg); or return $status
    end
    set -l args
    if test -n "$_flag_description"
        set args $args --description $_flag_description
    end
    tea pulls create --title $title $aGS
end

function __gitea_exists
    set -l branch (git current-branch); or return $status
    __gitea_pulls_json >/dev/null 2>&1
    set -l json_status $status
    if test $json_status -eq 0
        return 0
    else if test $json_status -eq 100
        return 1
    else if test $json_status -eq 101
        echo "'__gitea_exists' expected a unique MR for '$branch'" >&2; and return 1
    else
        echo "'__gitea_exists' expected an exit status of 0, 100 or 101; got $json_status" >&2; and return 1
    end
end

function __gitea_merge
    argparse exit -- $argv; or return $status
    set -l curr_branch (git current-branch); or return $status
    if not __gitea_exists
        echo "'__gitea_merge' could not find an open PR for '$curr_branch'" >&2; and return 1
    end
    set -l index (__gitea_pulls_index); or return $status
    set -l repo (git repo-name); or return $status
    set -l start (date +%s); or return $status
    set -l i 0
    set -l elapsed
    while __gitea_exists
        if tea pull merge --style squash $index >/dev/null 2>&1; and not __gitea_exists
            break
        end
        set i (math $i+1)
        set elapsed (math (date +%s) - $start)
        echo "'$repo/$curr_branch' is still merging... ($i, $elapsed s)"
        sleep 10
    end
    set -l def_branch (git default-local-branch); or return $status
    set -l args
    if test -n "$_flag_exit"
        set args $args --exit
    end
    __git_checkout_close $def_branch --delete --delete-remote $args
end

function __gitea_pulls_json
    if test (count $argv) -ge 1
        echo "'__gitea_pulls_json' expected 0 arguments; got $(count $argv)" >&2; and return 1
    end
    set -l json (tea pulls list --fields index,state,author,author-id,url,title,body,mergeable,base,base-commit,head,diff,patch,created,updated,deadline,assignees,milestone,labels,comments --output=json); or return $status
    set -l branch (git current-branch); or return $status
    set json (echo $json | jq -r --arg branch "$branch" '[.[] | select(.head == $branch)]'); or return $status
    set -l num (echo $json | jq length); or return $status
    if test $num -eq 0
        echo "'__gitea_pulls_json' expected a PR for '$branch'; got none" >&2; and return 100
    else if test $num -eq 1
        printf "%s\n" "$json" | jq .[0]
    else
        echo "'__gitea_pulls_json' expected a unique PR for '$branch'; got $num" >&2; and return 101
    end
end

function __gitea_pulls_index
    if test (count $argv) -ge 1
        echo "'__gitea_pulls_index' expected 0 arguments; got $(count $argv)" >&2; and return 1
    end
    set -l json (__gitea_pulls_json); or return $status
    echo $json | jq -r .index
end

function __gitea_view
    set -l json (__gitea_pulls_json 2>&1)
    set -l json_status $status
    if test $json_status -eq 0
        set -l url (echo $json | jq -r .url); or return $status
        open $url
    else if type -q tea
        tea open
    else
        set -l branch (git current-branch); or return $status
        echo "'__gitea_view' could not find an open PR for '$branch'" >&2; and return 1
    end
end

#### github + gitlab ##########################################################

# create

function ghc
    set -l args
    if test (count $argv) -eq 0
        set args $args --title (__auto_msg)
    else if test (count $argv) -eq 1
        set args $args --title $argv[1]
    else if test (count $argv) -eq 2
        set args $args --title $argv[1] --body $argv[2]
    else
        echo "'ghc' expected [0..2] arguments TITLE BODY; got $(count $argv)" >&2; and return 1
    end
    __git_create $args
end

function __git_create
    argparse title= body= -- $argv; or return $status
    set -l args
    if test -n "$_flag_title"
        set args $args --title $_flag_title
    else
        set args $args --title (__auto_msg)
    end
    if __remote_is_github
        if test -n "$_flag_body"
            set args $args --body $_flag_body
        end
        __github_create $args
    else if __remote_is_gitlab
        if test -n "$_flag_body"
            set args $args --description $_flag_description
        end
        __gitlab_create $args
    else if __remote_is_gitea
        if test -n "$_flag_body"
            set args $args --description $_flag_description
        end
        __gitea_create $args
    else
        set -l remote $(git remote-name); or return $status
        echo "Invalid remote; got '$remote'" >&2; and return 1
    end
end

# edit

function ghe
    argparse title= body= -- $argv; or return $status
    set -l args
    if test -n "$_flag_title"
        set args $args --title $_flag_title
    end
    if test -n "$_flag_body"
        set args $args --body $_flag_body
    end
    if test (count $argv) -eq 0
    else if test (count $argv) -eq 1
        if test -n "$_flag_title"
            echo "'ghe' got 1 argument TITLE but also --title; got $(count $argv)" >&2; and return 1
        end
        set args $args --title $argv[1]
    else if test (count $argv) -eq 2
        if test -n "$_flag_title"
            echo "'ghe' got 2 arguments TITLE BODY but also --title; got $(count $argv)" >&2; and return 1
        else if test -n "$_flag_body"
            echo "'ghe' got 2 arguments TITLE BODY but also --body; got $(count $argv)" >&2; and return 1
        end
        set args $args --title $argv[1] --body $argv[2]
    else
        echo "'ghe' expected [1..2] arguments TITLE BODY; got $(count $argv)" >&2; and return 1
    end
    __git_edit $args
end

function __git_edit
    argparse title= body= -- $argv; or return $status
    set -l args
    if test -n "$_flag_title"
        set args $args --title $_flag_title
    end
    if __remote_is_github
        if test -n "$_flag_body"
            set args $args --body $_flag_body
        end
        __github_edit $args
    else if __remote_is_gitlab
        if test -n "$_flag_body"
            set args $args --description $_flag_description
        end
        __gitlab_update $args
    else
        set -l remote $(git remote-name); or return $status
        echo "Invalid remote; got '$remote'" >&2; and return 1
    end
end

# merge

function ghm
    __git_merge
end
function ghx
    __git_merge --exit
end

function __git_merge
    argparse exit -- $argv; or return $status
    set -l args
    if test -n "$_flag_exit"
        set args $args --exit
    end
    if __remote_is_github
        __github_merge $args
    else if __remote_is_gitlab
        __gitlab_merge $args
    else if __remote_is_gitea
        __gitea_merge $args
    else
        set -l remote $(git remote-name); or return $status
        echo "Invalid remote; got '$remote'" >&2; and return 1
    end
end

# view

function gw
    __git_view
end

function __git_view
    if __remote_is_github
        __github_view
    else if __remote_is_gitlab
        __gitlab_view
    else if __remote_is_gitea
        __gitea_view
    else
        set -l remote $(git remote-name); or return $status
        echo "Invalid remote; got '$remote'" >&2; and return 1
    end
end

#### git + github/gitlab ######################################################

function gg
    __git_all $argv
end
function ggn
    __git_all $argv --no-verify
end
function ggf
    __git_all $argv --force
end
function ggnf
    __git_all $argv --no-verify --force
end
function ggw
    __git_all $argv --web
end
function ggnw
    __git_all $argv --no-verify --web
end
function ggfw
    __git_all $argv --force --web
end
function ggnfw
    __git_all $argv --no-verify --force --web
end
function gge
    __git_all $argv --exit
end
function ggne
    __git_all $argv --no-verify --exit
end
function ggfe
    __git_all $argv --force --exit
end
function ggnfe
    __git_all $argv --no-verify --force --exit
end
function ggm
    __git_all $argv --merge
end
function ggnm
    __git_all $argv --no-verify --merge
end
function ggfm
    __git_all $argv --force --merge
end
function ggnfm
    __git_all $argv --no-verify --force --merge
end
function ggx
    __git_all $argv --merge --exit
end
function ggnx
    __git_all $argv --no-verify --merge --exit
end
function ggfx
    __git_all $argv --force --merge --exit
end
function ggnfx
    __git_all $argv --no-verify --force --merge --exit
end
#
function ggc
    if test (count $argv) -eq 0
        echo "'ggc' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] $argv[2..]
end
function ggcn
    if test (count $argv) -eq 0
        echo "'ggcn' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --no-verify $argv[2..]
end
function ggcf
    if test (count $argv) -eq 0
        echo "'ggcf' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --force $argv[2..]
end
function ggcnf
    if test (count $argv) -eq 0
        echo "'ggcnf' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --no-verify --force $argv[2..]
end
function ggcw
    if test (count $argv) -eq 0
        echo "'ggcw' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --web $argv[2..]
end
function ggcnw
    if test (count $argv) -eq 0
        echo "'ggcnw' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --no-verify --web $argv[2..]
end
function ggcfw
    if test (count $argv) -eq 0
        echo "'ggcfw' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --force --web $argv[2..]
end
function ggcnfw
    if test (count $argv) -eq 0
        echo "'ggcnfw' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --no-verify --force --web $argv[2..]
end
function ggce
    if test (count $argv) -eq 0
        echo "'ggce' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --exit $argv[2..]
end
function ggcne
    if test (count $argv) -eq 0
        echo "'ggcne' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --no-verify --exit $argv[2..]
end
function ggcfe
    if test (count $argv) -eq 0
        echo "'ggcfe' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --force --exit $argv[2..]
end
function ggcnfe
    if test (count $argv) -eq 0
        echo "'ggcnfe' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --no-verify --force --exit $argv[2..]
end
function ggcm
    if test (count $argv) -eq 0
        echo "'ggcm' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --merge $argv[2..]
end
function ggcnm
    if test (count $argv) -eq 0
        echo "'ggcnm' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --no-verify --merge $argv[2..]
end
function ggcfm
    if test (count $argv) -eq 0
        echo "'ggcfm' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --force --merge $argv[2..]
end
function ggcnfm
    if test (count $argv) -eq 0
        echo "'ggcnfm' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --no-verify --force --merge $argv[2..]
end
function ggcx
    if test (count $argv) -eq 0
        echo "'ggcx' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --merge --exit $argv[2..]
end
function ggcnx
    if test (count $argv) -eq 0
        echo "'ggcnx' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --no-verify --merge --exit $argv[2..]
end
function ggcfx
    if test (count $argv) -eq 0
        echo "'ggcfx' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --force --merge --exit $argv[2..]
end
function ggcnfx
    if test (count $argv) -eq 0
        echo "'ggcnfx' expected [1..) arguments TITLE; got $(count $argv)" >&2; and return 1
    end
    __git_all --title=$argv[1] --no-verify --force --merge --exit $argv[2..]
end

function __git_all
    argparse title= num= part no-verify force web exit merge -- $argv; or return $status

    if test -n "$_flag_title"
        set -l checkout_args
        if test -n "$_flag_title"
            set checkout_args $checkout_args --title $_flag_title
        end
        if test -n "$_flag_num"
            set checkout_args $checkout_args --num $_flag_num
        end
        if test -n "$_flag_part"
            set checkout_args $checkout_args --part
        end
        __git_checkout_open $checkout_args; or return $status
    end

    __git_add $argv; or return $status # don't use force

    set -l commit_push_args
    if test -n "$_flag_no_verify"
        set commit_push_args $commit_push_args --no-verify
    end
    if test -n "$_flag_force"
        set commit_push_args $commit_push_args --force
    end
    if test -n "$_flag_web"
        set commit_push_args $commit_push_args --web
    end
    if test -n "$_flag_exit"; and test -z "$_flag_merge"
        set commit_push_args $commit_push_args --exit
    end
    __git_commit_until_push $commit_push_args; or return $status

    if test -n "$_flag_merge"
        set -l merge_args
        if test -n "$_flag_exit"
            set merge_args $merge_args --exit
        end
        __git_merge $merge_args
    end
end

#### utilities ################################################################

function __auto_msg
    echo (date "+%Y-%m-%d %H:%M:%S (%a)") " >" (hostname) " >" $USER
end

function __clean_branch_name
    if test (count $argv) -eq 0
        echo "'__clean_branch_name' expected [1..) arguments BRANCH; got $(count $argv)" >&2; and return 1
    end
    echo $argv[1] | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' \
        | sed -E 's/^-+|-+$//g' | cut -c1-80
end
