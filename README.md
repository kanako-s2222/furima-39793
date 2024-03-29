# README


# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| birthday           | date   | null: false               |

### Association

- has_many :items
- has_many :orders


## items テーブル

| Column            | Type       | Options                        |
| ------------------| -----------| -------------------------------|
| item_name         | string     | null: false                    |
| explain           | text       | null: false                    |
| category_id       | integer    | null: false                    |
| condition_id      | integer    | null: false                    |
| delivery_price_id | integer    | null: false                    |
| place_id          | integer    | null: false                    |
| delivery_day_id  	| integer    | null: false                    |
| price             | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |


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
| place_id       | integer    | null: false                    |
| city           | string     | null: false                    |
| street         | string     | null: false                    |
| building       | string     |                                |
| phone_number   | string     | null: false                    |
| order          | references | null: false, foreign_key: true |

### Association

- belongs_to :order
- 