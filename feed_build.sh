#!/bin/bash -e
get_latest_release() {
    url=https://api.github.com/repos/$1/releases?per_page=1
    curl $url | grep tag_name | cut -d '"' -f 4
}

# Read JSON config file
config=$(cat config.json)
if [ -d "openwrt-packages" ]; then
  rm -rf openwrt-packages
fi

echo "$config"
# Loop through each repository in the config
for repo in $(echo $config | jq -c '.[]'); do
  # Parse config and assign values to variables
  url=$(echo $repo | jq -r '.URL')
  branch=$(echo $repo | jq -r '.branch')
  subdir=$(echo $repo | jq -r '.subdir[]?')
  tag=$(echo $repo | jq -r '.tag')
  use_latest_tag=$(echo $repo | jq -r '.use_latest_tag')

  repo_name=$(echo $url | sed 's/.*\///' | sed 's/.git//')
  # https://github.com/vernesong/OpenClash.git
  author=$(echo $url | awk -F'/' '{print $4}')

  # Check out branch or tag
  if [[ $use_latest_tag == true ]]; then
    latest_tag=$(get_latest_release "$author/$repo_name")
    if [ -z "$latest_tag" ]; then
      echo "No latest tag found"
      exit 1
    fi
    git clone --depth 1 --branch $latest_tag $url
  elif [[ ! -z $tag && $tag != "latest" ]] && [ "$tag" != "null" ]; then
    git clone --depth 1 --branch $tag $url
  elif [[ ! -z $branch ]] && [ $branch != "null" ]; then
    git clone --depth 1 --branch $branch $url
  else
    git clone --depth 1 $url
  fi

  # Move subdirectories to "packages" folder
  if [[ ! -d openwrt-packages ]]; then
    mkdir openwrt-packages
  fi
  if [[ ! -z $subdir ]]; then
    for dir in $subdir; do
      last_path=$(echo $dir | sed 's/.*\///')
      cp -r $repo_name/$dir openwrt-packages/$last_path
    done
  else
    cp -r $repo_name openwrt-packages/$repo_name
  fi

  # Remove cloned repository
  rm -rf $repo_name
done
