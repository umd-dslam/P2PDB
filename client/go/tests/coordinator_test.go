// Copyright 2019 DSLAM (http://dslam.cs.umd.edu/). All rights reserved.
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
package main

import (
	"crypto/tls"
	"database/sql"
	presto "github.com/prestodb/presto-go-client/presto"
	"github.com/stretchr/testify/assert"
	"net"
	"net/http"
	"testing"
	"time"
)

// TestCoordinator launchs user's requests to coordinator, and to contractor
func TestCoordinator(t *testing.T) {
	client := &http.Client{
		Transport: &http.Transport{
			Proxy: http.ProxyFromEnvironment,
			DialContext: (&net.Dialer{
				Timeout:   30 * time.Second,
				KeepAlive: 30 * time.Second,
				DualStack: true,
			}).DialContext,
			MaxIdleConns:          100,
			IdleConnTimeout:       90 * time.Second,
			TLSHandshakeTimeout:   10 * time.Second,
			ExpectContinueTimeout: 1 * time.Second,
			TLSClientConfig:       &tls.Config{
				// your config here...
			},
		},
	}

	presto.RegisterCustomClient("p2pdb-client", client)
	db, err := sql.Open("presto", "http://johnsnow@localhost:8080?custom_client=p2pdb-client&catalog=timescaledb&schema=default")
	if err != nil {
		t.Fatal(err)
	}
	defer db.Close()

	rows, err := db.Query("SELECT * FROM timescaledb.public.table1")
	if err != nil {
		t.Fatal(err)
	}
	if err := rows.Err(); err != nil {
		t.Fatal(err)
	}
	defer rows.Close()

	for rows.Next() {
		var (
			v1 string
			v2 string
		)
		if err := rows.Scan(&v1, &v2); err != nil {
			t.Fatal(err)
		}
		assert.Equal(t, v1, "a")
		assert.Equal(t, v2, "aaaa")
	}
}
