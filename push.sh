BRANCH="packages/${ARCH::-2}"
if [[ $ARCH =~ "snapshot" ]]; then
    BRANCH="packages/$ARCH"
fi
cd bin/packages/*/action
sudo chown runner:runner -R .
git init
git config user.name "bot"
git config user.email "bot@github.com"
git add .
git commit -m "$(TZ='Asia/Shanghai' date +@%Y%m%d)"
git push --force --quiet "https://x-access-token:${{ secrets.GITHUB_TOKEN }}@github.com/$GITHUB_REPOSITORY" HEAD:$BRANCH