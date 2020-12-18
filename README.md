# Rails Engine - An E-Commerce API

  <h3 align="center">Rails Engine</h3>

  <p align="center">
    Rails Engine is an API developed for an E-Commerce Application. The fictitious company utilizes a service-oriented architecture, and thus has a separate back-end service (this API!). This repo exposes the data that powers the company's site through a RESTful JSON API in addition to custom endpoints for Business Intelligence Analytics.
    <br />
    <a href="https://github.com/helloeduardo/rails-engine/issues">Report Bug</a>
    ·
    <a href="https://github.com/helloeduardo/rails-engine/issues">Request Feature</a>
  </p>
</p>


<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
  * [Schema](#schema)
* [Usage](#usage)
  * [Endpoints](#endpoints)
    * [Index of Resource](#index-of-resource)
    * [Show Record](#show-record)
    * [Create Record](#create-record)
    * [Update Record](#update-record)
    * [Destroy Record](#destroy-record)
    * [Merchant Items Relationship](#merchant-items-relationship)
    * [Item Merchant Relationship](#item-merchant-relationship)
    * [Find One Resource By Attribute](#find-one-resource-by-attribute)
    * [Find Many Resources By Attribute](#find-many-resources-by-attribute)
    * [Merchants with Most Revenue](#merchants-with-most-revenue)
    * [Merchants with Most Items Sold](#merchants-with-most-items-sold)
    * [Revenue across Date Range](#revenue-across-date-range)
    * [Revenue for a Merchant](#revenue-for-a-merchant)
* [Contributing](#contributing)
* [Contact](#contact)


<!-- ABOUT THE PROJECT -->
## About The Project

Rails Engine exposes business data based on the [JSON API Specification](https://jsonapi.org) via multiple API endpoints allowing other developers access to CRUD functionality for Merchants and Items, obtaining relationship information for Merchants and Items, and exposes more complex endpoints including: merchants with the most revenue, merchants with the most items sold, revenue across a date range, and revenue for a specific merchant.


<!-- GETTING STARTED -->
## Getting Started

To use Rails Engine locally, you can fork or clone [this](https://github.com/helloeduardo/rails-engine) repo.

### Prerequisites
* [Ruby 2.5.3](https://github.com/ruby/ruby)
* [Rails 5.2.4.4](https://github.com/rails/rails)

### Installation
Below are the commands you will need to run in your terminal once you are inside the rails-engine directory.

* Bundle Install
```
$ bundle exec install
```
* Set up Database
```
$ rails db:create
$ rails db:migrate
$ rails db:seed
```

### Schema

After running your migrations, your schema will look something like this!
<br />
<p align="center">
    <img src="https://user-images.githubusercontent.com/56360157/102575457-5c2ff280-40b0-11eb-8b59-f8bbc394d3be.png">
</p>


<!-- USAGE EXAMPLES -->
## Usage

Run ```rails s``` in your terminal and utilize ```http://localhost:3000/``` as the base url in your API client of choice (Postman, etc.)

### Endpoints

#### Index of Resource

This endpoint renders a JSON representation of all records of the requested resource.

`GET /api/v1/<resource>` where `<resource>` is `merchants` or `items`

Example JSON response for the Merchant resource:
```json
{
  "data": [
    {
      "id": "1",
        "type": "merchant",
        "attributes": {
          "name": "Mike's Awesome Store",
        }
    },
    {
      "id": "2",
      "type": "merchant",
      "attributes": {
        "name": "Store of Fate",
      }
    }
  ]
}
```

#### Show Record

This endpoint renders a JSON representation of the corresponding record.

`GET /api/v1/<resource>/:id` where `<resource>` is `merchants` or `items`

Example JSON response for the Merchant resource:
```json
{
  "data": {
    "id": "1",
    "type": "merchant",
    "attributes": {
      "name": "Store Name"
    }
  }
}
```

#### Create Record

This endpoint creates a record and renders a JSON representation of the new record.

`POST /api/v1/<resource>` where `<resource>` is `merchants` or `items`

The request body should follow this pattern:
```json
{
  "attribute1": "value1",
  "attribute2": "value2"
}
```

Example JSON response for the Merchant resource:
```json
{
  "data": {
    "id": "1",
    "type": "merchant",
    "attributes": {
      "name": "Store Name"
    }
  }
}
```

#### Update Record

This endpoint updates the corresponding record and renders a JSON representation of the updated record.

`PATCH /api/v1/<resource>/:id` where `<resource>` is `merchants` or `items`

The request body should follow this pattern:
```json
{
  "attribute1": "value1",
  "attribute2": "value2"
}
```

Example JSON response for the Merchant resource:
```json
{
  "data": {
    "id": "1",
    "type": "merchant",
    "attributes": {
      "name": "Store Name"
    }
  }
}
```

#### Destroy Record

This endpoint destroys the corresponding record and any associated data.

`DELETE /api/v1/<resource>/:id` where `<resource>` is `merchants` or `items`

The response returns a 204 HTTP status code.

#### Merchant Items Relationship
`GET /api/v1/merchants/:id/items` - returns all items associated with a merchant.

Example JSON response:
```json
{
    "data": [
        {
            "id": "80",
            "type": "item",
            "attributes": {
                "name": "Item In Sed",
                "description": "Voluptas aliquid dolores deserunt dolor ipsa.",
                "unit_price": 548.08,
                "merchant_id": 4
            }
        },
        {
            "id": "81",
            "type": "item",
            "attributes": {
                "name": "Item Neque Aliquam",
                "description": "Laudantium non rerum rerum consequuntur.",
                "unit_price": 137.74,
                "merchant_id": 4
            }
        }
    ]
}
```

#### Item Merchant Relationship
`GET /api/v1/items/:id/merchants` - returns the merchant associated with an item

Example JSON response:
```json
{
    "data": {
        "id": "1",
        "type": "merchant",
        "attributes": {
            "name": "Schroeder-Jerde"
        }
    }
}
```

#### Find One Resource By Attribute
This endpoint returns a single record that matches a set of criteria. Criteria will be input through query parameters.

`GET /api/v1/<resource>/find?<attribute>=<value>`

Example JSON response for `GET /api/v1/merchants/find?name=ring`
```json
{
  "data": {
    "id": 4,
    "type": "merchant",
    "attributes": {
      "name": "Ring World"
    }
  }
}
```

#### Find Many Resources By Attribute
This endpoint returns all records that match a set of criteria. Criteria will be input through query parameters.

`GET /api/v1/<resource>/find_all?<attribute>=<value>`

Example JSON response for `GET /api/v1/merchants/find_all?name=ring`
```json
{
  "data": [
    {
      "id": "4",
      "type": "merchant",
      "attributes": {
        "name": "Ring World"
      }
    },
    {
      "id": "1",
      "type": "merchant",
      "attributes": {
        "name": "Turing School"
      }
    }
  ]
}
```

#### Merchants with Most Revenue

This endpoint returns a variable number of merchants ranked by total revenue.

`GET /api/v1/merchants/most_revenue?quantity=x` where x is the number of merchants to be returned.

Example JSON response for `GET /api/v1/merchants/most_revenue?quantity=2`
```json
{
  "data": [
    {
      "id": "1",
      "type": "merchant",
      "attributes": {
        "name": "Turing School"
      }
    },
    {
      "id": "4",
      "type": "merchant",
      "attributes": {
        "name": "Ring World"
      }
    }
  ]
}
```

#### Merchants with Most Items Sold

This endpoint returns a variable number of merchants ranked by total number of items sold:

`GET /api/v1/merchants/most_items?quantity=x` where x is the number of merchants to be returned.

Example JSON response for `GET /api/v1/merchants/most_items?quantity=2`
```json
{
  "data": [
    {
      "id": "1",
      "type": "merchant",
      "attributes": {
        "name": "Turing School"
      }
    },
    {
      "id": "4",
      "type": "merchant",
      "attributes": {
        "name": "Ring World"
      }
    }
  ]
}
```

#### Revenue across Date Range

This endpoint should return the total revenue across all merchants between the given dates.

`GET /api/v1/revenue?start=<start_date>&end=<end_date>`

Example JSON response for `GET /api/v1/revenue?start=2012-03-09&end=2012-03-24`
```json
{
  "data": {
    "id": null,
    "attributes": {
      "revenue"  : 43201227.80
    }
  }
}
```

#### Revenue for a Merchant

This endpoint should return the total revenue for a single merchant.

`GET /api/v1/merchants/:id/revenue`

Example JSON response for `GET /api/v1/merchants/1/revenue`
```json
{
  "data": {
    "id": null,
    "attributes": {
      "revenue"  : 43201227.80
    }
  }
}
```
<!-- CONTRIBUTING -->
## Contributing

Contributions are what make this community such an amazing and fun place to learn, grow, and create! Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch ```git checkout -b feature/NewGreatFeature```
3. Commit your Changes ```git commit -m 'Add some NewGreatFeature'```
4. Push to the Branch ```git push origin feature/NewGreatFeature```
5. Open a new Pull Request!


<!-- CONTACT -->
## Contact

Eduardo Parra - [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/eduardo--parra/) - [GitHub](https://github.com/helloeduardo)


<!-- MARKDOWN LINKS & IMAGES -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
