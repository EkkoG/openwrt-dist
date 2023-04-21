#!/bin/bash -e
get_latest_release() {
    url=https://api.github.com/repos/$1/releases?per_page=1
    curl $url | grep tag_name | cut -d '"' -f 4
}

if [ -d "clone-work" ]; then
  rm -rf clone-work
  mkdir clone-work
else
  mkdir clone-work
fi

cd clone-work
cp ../config.json .

config=$(cat config.json)

echo "$config"
# Loop through each repository in the config
for repo in $(echo $config | jq -c '.[]'); do
  # Parse config and assign values to variables
  url=$(echo $repo | jq -r '.URL')
  branch=$(echo $repo | jq -r '.branch')
  subdir=$(echo $repo | jq -r '.subdir?')
  tag=$(echo $repo | jq -r '.tag')
  use_latest_tag=$(echo $repo | jq -r '.use_latest_tag')
  rename_to=$(echo $repo | jq -r '.rename_to')

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
  if [[ ! -d final-packages ]]; then
    mkdir final-packages
  fi

  if [[ ! -z $subdir ]] && [ "$subdir" != 'null' ]; then

    for dir_info in $(echo $subdir | jq -c '.[]'); do
      dir=$(echo $dir_info | jq -r '.dir')
      rename_to=$(echo $dir_info | jq -r '.rename_to')

      src_dir=$repo_name/$dir
      last_path=$(echo $dir | sed 's/.*\///')
      if [ $dir = '.' ]; then
        src_dir=$repo_name
        rm -rf $repo_name/.git
      fi
      if [[ ! -z $rename_to ]] && [ $rename_to != "null" ]; then
        last_path=$rename_to
      fi
      cp -r $src_dir final-packages/$last_path
    done
  else
    to_name=$repo_name
    rm -rf $repo_name/.git
    cp -r $repo_name final-packages/$to_name
  fi

  # Remove cloned repository
  rm -rf $repo_name
done

cp -r final-packages/* ..

cd ..

rm -rf clone-work