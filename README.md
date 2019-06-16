
[![CircleCI](https://circleci.com/gh/cyber-dojo-languages/image_namer.svg?style=svg)](https://circleci.com/gh/cyber-dojo-languages/image_namer)

- finds the image-name for a [cyber-dojo-languages](https://github.com/cyber-dojo-languages) repo.
- for a base-language repo, eg [cyber-dojo-languages/python](https://github.com/cyber-dojo-languages/python), this is the image_name property of its /docker/image_name.json file.
- for a test-framework repo, eg [cyber-dojo-languages/python-pytest](https://github.com/cyber-dojo-languages/python-pytest), this is the image_name property of its /start_point/image_name.json file.
- used in the main [build_test_push_notify.sh](https://github.com/cyber-dojo-languages/image_builder/blob/master/build_test_push_notify.sh) script of all [cyber-dojo-languages](https://github.com/cyber-dojo-languages) repos .circleci/config.yml files

```bash
$ cd /Users/jonjagger/repos/cyber-dojo-languages/python
$ docker run --rm --volume "${PWD}:/data:ro" cyberdojofoundation/image_namer
cyberdojofoundation/python
```

```bash
$ cd /Users/jonjagger/repos/cyber-dojo-languages/python-pytest
$ docker run --rm --volume "${PWD}:/data:ro" cyberdojofoundation/image_namer
cyberdojofoundation/python_pytest
```

- - - -

![cyber-dojo.org home page](https://github.com/cyber-dojo/cyber-dojo/blob/master/shared/home_page_snapshot.png)
