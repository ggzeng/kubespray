#! /bin/bash
# ZengGanghui 2018.12.16

repo_urls=`find ../ -type f -not -path "../my-scripts/*" | xargs grep "_image_repo: "| cut -d : -f2|sort`
echo "
---
- name: display docker images
  run_once: true
  tags:
    - images
  debug:
    verbosity: 3
    msg:" | tee display_images.yml
for url in ${repo_urls[@]};
do
    tag=${url/_repo/_tag}
    echo "      - \"$url - {{ $url | default('n') }}:{{ $tag | default('n') }}\"" | tee -a display_images.yml
done
