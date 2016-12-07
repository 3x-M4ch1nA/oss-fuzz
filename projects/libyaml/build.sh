#!/bin/bash -eu
# Copyright 2016 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################

cd libyaml

./bootstrap
./configure
make "-j$(nproc)"

$CXX $CXXFLAGS -std=c++11 -Iinclude \
    $SRC/libyaml_fuzzer.cc -o $OUT/libyaml_fuzzer \
    -lFuzzingEngine src/.libs/libyaml.a

cp $SRC/libyaml_fuzzer_seed_corpus.zip $OUT/
cp $SRC/*.dict $SRC/*.options $OUT/
