# frozen_string_literal: true

# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

desc "Run CI checks"

TESTS = ["unit", "rubocop", "yardoc", "build"]

flag :only
TESTS.each do |name|
  flag "test_#{name}".to_sym, "--[no-]test-#{name}"
end

include :exec, result_callback: :handle_result
include :terminal

def handle_result result
  if result.success?
    puts "** Passed: #{result.name}\n\n", :green, :bold
  else
    puts "** Failed: #{result.name}\n\n", :red, :bold
    @errors << result.name
  end
end

def run
  @errors = []
  ::Dir.chdir context_directory
  TESTS.each do |name|
    key = "test_#{name}".to_sym
    set key, !only if get(key).nil?
  end
  exec_separate_tool ["test"], name: "Unit tests" if test_unit
  exec_separate_tool ["rubocop"], name: "Style checker" if test_rubocop
  exec_separate_tool ["yardoc"], name: "Docs generation" if test_yardoc
  exec_separate_tool ["build"], name: "Gem build" if test_build
  @errors.each do |err|
    puts "Failed: #{err}", :red, :bold
  end
  exit 1 unless @errors.empty?
end
