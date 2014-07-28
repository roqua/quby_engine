# 2.1.3

* Increased required Virtus version from 1.0.0 to backward compatible 1.0.3.

# 2.1.0

* Removed default value for `Quby::Settings.shared_secret`. You will now have
  to set this yourself to an actual value.

# 2.0.0

* Moved lots of code. Added `Quby.questionnaires` and `Quby.answers` which
  provide a stable API. You can still expect breakage on anything other than
  these two API endpoints while we clean up the rest of Quby.
