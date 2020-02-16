# github-action-bucket-remove

Will remove a Textile Bucket

```
- name: Bucket remove action
  id: push
  uses: textileio/github-action-bucket-remove@master
  with:
    bucket-name: 'YOUR_BUCKET_NAME-${{ github.event.pull_request.id }}'
    token: ${{ secrets.TEXTILE_AUTH_TOKEN }}
```

This actions is meant be be used in conjunction with the Bucket Push action. See this repo's action configuration to see an example.

Create an action that will push and ephemeral bucket for your Pull Requests.

```
name: bucket_push
on:
  pull_request:
    branches:
      - master

jobs:
  bucket_push:
    runs-on: ubuntu-latest
    name: Remove a Textile Bucket
    steps:
    - name: Checkout
      uses: actions/checkout@v1
    - name: Bucket push action
      id: push
      uses: textileio/github-action-bucket-push@master
      with:
        bucket-name: 'YOUR_BUCKET_NAME-${{ github.event.pull_request.id }}'
        path: 'www/*'
        token: ${{ secrets.TEXTILE_AUTH_TOKEN }}
    # Use the output from the `hello` step
    - name: Get the output CID
      run: echo "The CID was ${{ steps.push.outputs.cid }}"
    - name: Get the Bucket URL
      run: echo "The Bucket URL is ${{ steps.push.outputs.url }}"
```

Replace `YOUR_BUCKET_NAME` with whatver bucket name you are using in production. Replace `path` with the path of your build folder or '*' for the entire repo. 

The above action will run on every Pull Request open and update the same ephemeral bucket each time you update the PR. 

NExt, create an action to remove the bucket when your PR is closed or merged.

```
name: bucket_push
on:
  pull_request:
    types: ['closed']

jobs:
  bucket_push:
    runs-on: ubuntu-latest
    name: Remove a Textile Bucket
    steps:
    - name: Checkout
      uses: actions/checkout@v1
    - name: Bucket remove action
      id: push
      uses: textileio/github-action-bucket-remove@master
      with:
        bucket-name: 'YOUR_BUCKET_NAME-${{ github.event.pull_request.id }}'
        token: ${{ secrets.TEXTILE_AUTH_TOKEN }}
```

Again, replace `YOUR_BUCKET_NAME` with your production bucket name.