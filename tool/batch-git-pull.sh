function update_git_repo() {
  GIT_UPDATE_DIR=$1
  if [ -d "$GIT_UPDATE_DIR" ]; then
    cd "$GIT_UPDATE_DIR"
  else
    echo "[ERROR] fail open dir $GIT_UPDATE_DIR"
    return 1
  fi

  # Solving the 'Your branch is ahead of 'origin/master' by x commits' issue after pulling using git.
  #if git pull origin master
  if git fetch && git merge origin/master
  then 
    echo "[SUCCESS] git update $GIT_UPDATE_DIR success."
  else
    echo "[ERROR] git update $GIT_UPDATE_DIR fail."
  fi
}

function batch_update_git() {
  for GIT_UPDATE_DIR in $@; do
    echo "[INFO] updating: $GIT_UPDATE_DIR"
    update_git_repo "$GIT_UPDATE_DIR"
    echo
  done
}

batch_update_git \
  "$HOME" \
  "$HOME"/c-learning \

echo '--- update finished ---'
