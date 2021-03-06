# Copyright (C) 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agrls eed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

.PHONY: general-tests

general-tests-zip := $(PRODUCT_OUT)/general-tests.zip
$(general-tests-zip): $(COMPATIBILITY.general-tests.FILES) $(SOONG_ZIP)
	echo $(COMPATIBILITY.general-tests.FILES) > $@.list
	sed -i -e 's/\s\+/\n/g' $@.list
	grep $(HOST_OUT_TESTCASES) $@.list > $@-host.list || true
	grep $(TARGET_OUT_TESTCASES) $@.list > $@-target.list || true
	$(hide) $(SOONG_ZIP) -d -o $@ -C $(HOST_OUT) -l $@-host.list -C $(PRODUCT_OUT) -l $@-target.list

general-tests: $(general-tests-zip)
$(call dist-for-goals, general-tests, $(general-tests-zip))
