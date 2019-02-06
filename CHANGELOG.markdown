# 2.6.0

* Changed normscore lookup to use a tree that is built from a single csv file.

# 2.5.2

* 6x Faster loading of questionnaires.

# 2.3.0

* Added `flags` and `textvars` fields. AnswerRepos need to implement these fields.
* `AnswerRepo#create` now receives an entity instead of a questionnaire key and
  a hash of attributes. This was not part of the public interface, so this
  shouldn't be breaking.

# 2.2.0

* Added `started_at` field. AnswerRepos need to implement this field.

# 2.1.1

* Increased required Virtus version from 1.0.0 to backward compatible 1.0.3.

# 2.1.0

* Removed default value for `Quby::Settings.shared_secret`. You will now have
  to set this yourself to an actual value.

# 2.0.0

* Moved lots of code. Added `Quby.questionnaires` and `Quby.answers` which
  provide a stable API. You can still expect breakage on anything other than
  these two API endpoints while we clean up the rest of Quby.
