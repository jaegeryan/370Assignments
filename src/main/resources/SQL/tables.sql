create table Consoles
(
    console_id       int auto_increment
        primary key,
    model            varchar(100)   not null,
    type             varchar(50)    null,
    storage_capacity varchar(20)    null,
    purchase_date    date           null,
    cost             decimal(10, 2) null,
    serial_number    varchar(100)   not null
);

create table Customers
(
    customer_id    int auto_increment
        primary key,
    first_name     varchar(50)                         not null,
    last_name      varchar(50)                         not null,
    email          varchar(100)                        not null,
    phone_number   varchar(15)                         null,
    address        text                                null,
    created_at     timestamp default CURRENT_TIMESTAMP null,
    rewards_points int       default 0                 null,
    constraint email
        unique (email)
);

create table Inventory
(
    inventory_id  int auto_increment
        primary key,
    console_id    int                                                             not null,
    serial_number varchar(100)                                                    not null,
    status        enum ('Available', 'Rented', 'Maintenance') default 'Available' null,
    constraint serial_number
        unique (serial_number),
    constraint inventory_ibfk_1
        foreign key (console_id) references Consoles (console_id)
            on update cascade on delete cascade
);

create index console_id
    on Inventory (console_id);

create table Membership_Rewards
(
    Customer_ID        int          not null,
    Reward_ID          int auto_increment
        primary key,
    Reward_points      int          null,
    Reward_date        date         null,
    Reward_description varchar(255) null,
    constraint Customer_ID
        unique (Customer_ID, Reward_ID),
    constraint membership_rewards_ibfk_1
        foreign key (Customer_ID) references Customers (customer_id)
);

create table Rentals
(
    rental_id         int auto_increment
        primary key,
    customer_id       int                                                     not null,
    inventory_id      int                                                     not null,
    rental_start_date datetime                                                not null,
    rental_end_date   datetime                                                null,
    rental_status     enum ('Ongoing', 'Completed') default 'Ongoing'         null,
    total_cost        decimal(10, 2)                                          null,
    created_at        timestamp                     default CURRENT_TIMESTAMP null,
    constraint rentals_ibfk_1
        foreign key (customer_id) references Customers (customer_id)
            on update cascade on delete cascade,
    constraint rentals_ibfk_2
        foreign key (inventory_id) references Inventory (inventory_id)
            on update cascade on delete cascade
);

create index customer_id
    on Rentals (customer_id);

create index inventory_id
    on Rentals (inventory_id);

create table Transactions
(
    transaction_id   int auto_increment
        primary key,
    rental_id        int                                                               not null,
    amount           decimal(10, 2)                                                    not null,
    transaction_date datetime default CURRENT_TIMESTAMP                                null,
    payment_method   enum ('Cash', 'Credit Card', 'Debit Card', 'Online', 'Cancelled') not null,
    constraint transactions_ibfk_1
        foreign key (rental_id) references Rentals (rental_id)
            on update cascade on delete cascade
);

create index rental_id
    on Transactions (rental_id);

create table VIP_Customers
(
    Customer_ID         int           not null
        primary key,
    Membership_Level    varchar(50)   null,
    Additional_Discount decimal(5, 2) null,
    constraint vip_customers_ibfk_1
        foreign key (Customer_ID) references Customers (customer_id)
);

