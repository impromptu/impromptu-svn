impromptu-svn
=============

An SVN module for Impromptu.


## Section examples

```coffeescript
  section 'svn:trunk',
    content: 'SVN trunk'
    when: svn.trunk

  section 'svn:tag',
    content: svn.tag
    when: svn.tag
    format: (tag) ->
      "SVN tag: #{tag}"

  section 'svn:branch',
    content: svn.branch
    when: svn.branch
    format: (branch) ->
      "SVN tag: #{branch}"
```
