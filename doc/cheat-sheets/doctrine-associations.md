# Doctrine Associations

## 1. Many-To-One, Unidirectional

##### PHP
    class User
    {
        /**
         * @ManyToOne(targetEntity="Address")
         * @JoinColumn(name="address_id", referencedColumnName="id")
         */
        private $address;
    }
    class Address
    {
    }
##### SQL
    CREATE TABLE User (
        id INT AUTO_INCREMENT NOT NULL,
        address_id INT DEFAULT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    CREATE TABLE Address (
        id INT AUTO_INCREMENT NOT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    ALTER TABLE User ADD FOREIGN KEY (address_id) REFERENCES Address(id);

## 2. One-To-One, Unidirectional

##### PHP
    class Product
    {
        /**
         * @OneToOne(targetEntity="Shipping")
         * @JoinColumn(name="shipping_id", referencedColumnName="id")
         */
        private $shipping;
    }
    class Shipping
    {
    }
##### SQL
    CREATE TABLE Product (
        id INT AUTO_INCREMENT NOT NULL,
        shipping_id INT DEFAULT NULL,
        UNIQUE INDEX UNIQ_6FBC94267FE4B2B (shipping_id),
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    CREATE TABLE Shipping (
        id INT AUTO_INCREMENT NOT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    ALTER TABLE Product ADD FOREIGN KEY (shipping_id) REFERENCES Shipping(id);

## 3. One-To-One, Bidirectional

##### PHP
    class Customer
    {
        /**
         * @OneToOne(targetEntity="Cart", mappedBy="customer")
         */
        private $cart;
    }
    class Cart
    {
        /**
         * @OneToOne(targetEntity="Customer", inversedBy="cart")
         * @JoinColumn(name="customer_id", referencedColumnName="id")
         */
        private $customer;
    }
##### SQL

    CREATE TABLE Cart (
        id INT AUTO_INCREMENT NOT NULL,
        customer_id INT DEFAULT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    CREATE TABLE Customer (
        id INT AUTO_INCREMENT NOT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    ALTER TABLE Cart ADD FOREIGN KEY (customer_id) REFERENCES Customer(id);

## 4. One-To-One, Self-referencing

##### PHP
    class Student
    {
        /**
         * @OneToOne(targetEntity="Student")
         * @JoinColumn(name="mentor_id", referencedColumnName="id")
         */
        private $mentor;
    }
##### SQL
    CREATE TABLE Student (
        id INT AUTO_INCREMENT NOT NULL,
        mentor_id INT DEFAULT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    ALTER TABLE Student ADD FOREIGN KEY (mentor_id) REFERENCES Student(id);

## 5. One-To-Many, Bidirectional

##### PHP
    class Product
    {
        /**
         * @OneToMany(targetEntity="Feature", mappedBy="product")
         */
        private $features;
        public function __construct() {
            $this->features = new ArrayCollection();
        }
    }
    class Feature
    {
        /**
         * @ManyToOne(targetEntity="Product", inversedBy="features")
         * @JoinColumn(name="product_id", referencedColumnName="id")
         */
        private $product;
    }
##### SQL
    CREATE TABLE Product (
        id INT AUTO_INCREMENT NOT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    CREATE TABLE Feature (
        id INT AUTO_INCREMENT NOT NULL,
        product_id INT DEFAULT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    ALTER TABLE Feature ADD FOREIGN KEY (product_id) REFERENCES Product(id);

## 6. One-To-Many, Unidirectional with Join Table

##### PHP
    class User
    {
        /**
         * @ManyToMany(targetEntity="Phonenumber")
         * @JoinTable(name="users_phonenumbers",
         *      joinColumns={@JoinColumn(
         *          name="user_id",
         *          referencedColumnName="id")},
         *      inverseJoinColumns={@JoinColumn(
         *          name="phonenumber_id",
         *          referencedColumnName="id", unique=true)}
         * )
         */
        private $phonenumbers;
        public function __construct()
        {
            $this->phonenumbers = new ArrayCollection();
        }
    }
    class Phonenumber
    {
    }
##### SQL
    CREATE TABLE User (
        id INT AUTO_INCREMENT NOT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    CREATE TABLE users_phonenumbers (
        user_id INT NOT NULL,
        phonenumber_id INT NOT NULL,
        UNIQUE INDEX users_phonenumbers_phonenumber_id_uniq (phonenumber_id),
        PRIMARY KEY(user_id, phonenumber_id)
    ) ENGINE = InnoDB;
    CREATE TABLE Phonenumber (
        id INT AUTO_INCREMENT NOT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    ALTER TABLE users_phonenumbers
        ADD FOREIGN KEY (user_id) REFERENCES User(id);
    ALTER TABLE users_phonenumbers
        ADD FOREIGN KEY (phonenumber_id) REFERENCES Phonenumber(id);

## 7. One-To-Many, Self-referencing

##### PHP
    class Category
    {
        /**
         * @OneToMany(targetEntity="Category", mappedBy="parent")
         */
        private $children;
        /**
         * @ManyToOne(targetEntity="Category", inversedBy="children")
         * @JoinColumn(name="parent_id", referencedColumnName="id")
         */
        private $parent;
        public function __construct() {
            $this->children = new ArrayCollection();
        }
    }
##### SQL
    CREATE TABLE Category (
        id INT AUTO_INCREMENT NOT NULL,
        parent_id INT DEFAULT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    ALTER TABLE Category ADD FOREIGN KEY (parent_id) REFERENCES Category(id);

## 8. Many-To-Many, Unidirectional

##### PHP
    class User
    {
        /**
         * @ManyToMany(targetEntity="Group")
         * @JoinTable(name="users_groups",
         *      joinColumns={@JoinColumn(
         *          name="user_id",
         *          referencedColumnName="id")},
         *      inverseJoinColumns={@JoinColumn(
         *          name="group_id",
         *          referencedColumnName="id")}
         * )
         */
        private $groups;
        public function __construct() {
            $this->groups = new ArrayCollection();
        }
    }
    class Group
    {
    }
##### SQL
    CREATE TABLE User (
        id INT AUTO_INCREMENT NOT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    CREATE TABLE users_groups (
        user_id INT NOT NULL,
        group_id INT NOT NULL,
        PRIMARY KEY(user_id, group_id)
    ) ENGINE = InnoDB;
    CREATE TABLE Group (
        id INT AUTO_INCREMENT NOT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    ALTER TABLE users_groups ADD FOREIGN KEY (user_id) REFERENCES User(id);
    ALTER TABLE users_groups ADD FOREIGN KEY (group_id) REFERENCES Group(id);

## 9. Many-To-Many, Bidirectional

##### PHP
    class User
    {
        /**
         * @ManyToMany(targetEntity="Group", inversedBy="users")
         * @JoinTable(name="users_groups")
         */
        private $groups;
        public function __construct() {
            $this->groups = new ArrayCollection();
        }
    }
    class Group
    {
        /**
         * @ManyToMany(targetEntity="User", mappedBy="groups")
         */
        private $users;
        public function __construct() {
            $this->users = new ArrayCollection();
        }
    }
##### SQL
    CREATE TABLE User (
        id INT AUTO_INCREMENT NOT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    CREATE TABLE users_groups (
        user_id INT NOT NULL,
        group_id INT NOT NULL,
        PRIMARY KEY(user_id, group_id)
    ) ENGINE = InnoDB;
    CREATE TABLE Group (
        id INT AUTO_INCREMENT NOT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    ALTER TABLE users_groups ADD FOREIGN KEY (user_id) REFERENCES User(id);
    ALTER TABLE users_groups ADD FOREIGN KEY (group_id) REFERENCES Group(id);

## 10. Many-To-Many, Self-referencing

##### PHP
    class User
    {
        /**
         * @ManyToMany(targetEntity="User", mappedBy="myFriends")
         */
        private $friendsWithMe;
        /**
         * @ManyToMany(targetEntity="User", inversedBy="friendsWithMe")
         * @JoinTable(name="friends",
         *      joinColumns={@JoinColumn(
         *          name="user_id",
         *          referencedColumnName="id")},
         *      inverseJoinColumns={@JoinColumn(
         *          name="friend_user_id",
         *          referencedColumnName="id")}
         * )
         */
        private $myFriends;
        public function __construct() {
            $this->friendsWithMe = new ArrayCollection();
            $this->myFriends = new ArrayCollection();
        }
    }
##### SQL
    CREATE TABLE User (
        id INT AUTO_INCREMENT NOT NULL,
        PRIMARY KEY(id)
    ) ENGINE = InnoDB;
    CREATE TABLE friends (
        user_id INT NOT NULL,
        friend_user_id INT NOT NULL,
        PRIMARY KEY(user_id, friend_user_id)
    ) ENGINE = InnoDB;
    ALTER TABLE friends ADD FOREIGN KEY (user_id) REFERENCES User(id);
    ALTER TABLE friends ADD FOREIGN KEY (friend_user_id) REFERENCES User(id);

## Additional Informations

##### Initializing Collections

    class User
    {
        /**
         * @ManyToMany(targetEntity="Group")
         */
        private $groups;
        public function __construct()
        {
            $this->groups = new ArrayCollection();
        }
        public function getGroups()
        {
            return $this->groups;
        }
    }

    $group = new Group();
    $user = new User();
    $user->getGroups()->add($group);

##### Owning Side and Inverse Side

When mapping bidirectional associations it is important to understand the concept of the owning and inverse sides. The following general rules apply:

 * Relationships may be bidirectional or unidirectional.
 * A bidirectional relationship has both an owning side and an inverse side
 * A unidirectional relationship only has an owning side.
 * Doctrine will only check the owning side of an association for changes.

The following rules apply to bidirectional associations:

 * The **inverse side** has to use the mappedBy attribute of the OneToOne, OneToMany, or ManyToMany mapping declaration. The mappedBy attribute contains the name of the association-field on the owning side.
 * The **owning side** has to use the inversedBy attribute of the OneToOne, ManyToOne, or ManyToMany mapping declaration. The inversedBy attribute contains the name of the association-field on the inverse-side.
 * ManyToOne is always the owning side of a bidirectional association.
 * OneToMany is always the inverse side of a bidirectional association.
 * The owning side of a OneToOne association is the entity with the table containing the foreign key.
 * You can pick the owning side of a many-to-many association yourself.

___

###### References

 1. [ORM Cheatsheet](http://ormcheatsheet.com/)
