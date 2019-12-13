# -*- coding: utf-8 -*-
# Copyright 2019 DSLAM (http://dslam.cs.umd.edu/). All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import unittest
import prestodb


class TestCoordinatorMethods(unittest.TestCase):
    def test_upper(self):
        conn = prestodb.dbapi.connect(
            host='localhost',
            port=8080,
            user='johnsnow',
            catalog='timescaledb',
            schema='default',
        )
        cur = conn.cursor()
        cur.execute('SELECT * FROM timescaledb.public.table1')
        rows = cur.fetchall()
        self.assertEqual(rows[0][0], u'a')
        self.assertEqual(rows[0][1], u'aaaa')


if __name__ == '__main__':
    unittest.main()
