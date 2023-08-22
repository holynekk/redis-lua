redis-cli --raw

json.set foo . '{"foo": "bar"}'

json.get foo

json.type foo

json.type foo .foo

json.set foo .test 1

json.strlen foo .foo

json.objlen foo

json.objkeys foo

json.numincrby foo .test 2

json.nummultby foo .test 2

json.del foo .test
