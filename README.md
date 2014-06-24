# zipkin-cookbook

This is a chef cookbook for installing and configuring twitter/zipkin

http://twitter.github.io/zipkin/index.html

https://github.com/twitter/zipkin

## Supported Platforms

ubuntu 12.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['zipkin']['install_path']</tt></td>
    <td>String</td>
    <td>Where to install zipkin</td>
    <td><tt>/opt/zipkin</tt></td>
  </tr>
  <tr>
    <td><tt>['zipkin']['version']</tt></td>
    <td>String (SemVer)</td>
    <td>the release to install from github releases</td>
    <td><tt>1.1.0</tt></td>
  </tr>
  <tr>
    <td><tt>['zipkin']['web_port']</tt></td>
    <td>Integer</td>
    <td>TCP Port for web service to listen on</td>
    <td><tt>8080</tt></td>
  </tr>
  <tr>
    <td><tt>['zipkin']['query_host']</tt></td>
    <td>String</td>
    <td>IP/Hostname for web service to send queries to</td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>['zipkin']['query_port']</tt></td>
    <td>Integer</td>
    <td>TCP Port for web service to send queries to</td>
    <td><tt>9411</tt></td>
  </tr>
</table>

## Usage

### zipkin::default

Include `zipkin` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[zipkin]"
  ]
}
```

### zipkin::collector

### zipkin::query

### zipkin::web

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

License:: Apache 2.0
Author:: Dana Powers (<dana.powers@rd.io>)
