# frozen_string_literal: true

# This is required due to a bug in the activerecord-postgis-adapter gem due to
# its reliance on rgeo-activerecord version 8.0.0 which is broken
require "rgeo/active_record"
require "activerecord-postgis-adapter"
