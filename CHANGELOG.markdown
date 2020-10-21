# Upcoming

# 4.0.2

* Added option context_free_description

# 4.0.1

* Fix some options description html breaking table views.

# 4.0.0

* Added Answer#score_objects which exposes answer scores as Score and Subscore objects enriched with score schema information.
* BREAKING CHANGES: Renamed SubScoreSchema to SubscoreSchema. Renamed ScoreSchema#sub_score_schemas to #subscore_schemas.

# 3.2.2

* Added add_lookup_tree method to create a range_tree from within the dsl.

# 3.2.1

* Added Rails 6 compatibility

# 3.2.0

* Released to rubygems.org

# 3.0.0

* Changed normscore lookup to use a tree that is built from a single csv file.
* Add `required_components` attribute for date questions.

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
