# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions


# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| password           | string | null: false |
| first_name         | string | null: false |
| last_name          | string | null: false |
| first_name_kana    | string | null: false |
| last_name_kana     | string | null: false |

### Association

- has_many :items
- has_many :orders


## items テーブル

| Column       | Type   | Options     |
| -------------| ------ | ----------- |
| name         | string | null: false |
| info         | string | null: false |
| category_id  | string | null: false |
| condition_id | string | null: false |
| price        | string | null: false |
| prefecture_id| string | null: false |
| user         | string | null: false |


### Association

- has_one :order
- belongs_to :user


## orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| item   | references | null: false, foreign_key: true |
| user   | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :address


## addresses テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| postal_code    | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| city           | string     | null: false                    |
| block_number   | string     | null: false                    |
| building       | string     |                                |
| phone_number   | string     | null: false                    |
| order          | string     | null: false, foreign_key: true |

### Association

- belongs_to :order
- 