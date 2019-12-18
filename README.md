# hcl2json.jq
Use this in tandem with json2hcl -reverse to extract info from tf files. (Keeping all your data in json as source of truth is better tbh)

I've been using [json2hcl](https://github.com/kvz/json2hcl) for slurping data out the hcl files, for reasons beyond my understanding.
json2hcl reverse output is hard to follow for me. So I made this library to make it more intuitive.

### Usage example.

* Given:
** Install [json2hcl](https://github.com/kvz/json2hcl)
** Put hcl2json.jq in your `~/.jq` folder
  ```
  mkdir -p "$HOME/.jq"
  wget https://raw.githubusercontent.com/nhtzr/hcl2json.jq/master/hcl2json.jq -O "$HOME/.jq/hcl2json.jq"
  ```
** this script as `get_name.jq`
  ```
  include "hcl2json";
  tf_file.variable.my_map[] | select(.id==4) | "\(.greet) \(.name)"
  ```
** And this tf file `test.tf`
  ```
  variable "my_map" {
      default = {
        "test" = {
          id = 4
          greet = "hello"
          name = "world"
        }
      }
  }
  ```
* Test:
  ```
  json2hcl -reverse < test.tf | jq -ref get_name.jq
  ```
* Result:
  ```
  hello world
  ```
  
Versions used:
 * jq: jq-1.6
 * json2hcl: v0.0.6
 * tf 0.11.11

