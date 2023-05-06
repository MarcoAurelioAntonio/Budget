<a name="readme-top"></a>

<h3><b>Money Blackhole</b></h3>

<!-- TABLE OF CONTENTS -->

# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
  - [📽️ Project Documentation](#documentation)
  - [🚀 Live Demo](#live-demo)
- [💻 Getting Started](#getting-started)
  - [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Install](#install)
  - [Usage](#usage)
  - [Run tests](#run-tests)
- [👥 Authors](#authors)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)
- [🙏 Acknowledgements](#acknowledgements)
- [📝 License](#license)

<!-- PROJECT DESCRIPTION -->

# 📖 Smart Budget <a name="about-project"></a>

**Money Blackhole** is a mobile web application where you can manage your budget: you have a list of transactions associated with a category, so that you can see how much money you spent and on what. The Ruby on Rails application allows the user to:

 - Register and log in, so that the data is private to them.
 - Introduce new transactions associated with a category.
 - See the money spent on each category.

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
  <summary>Client</summary>
  <ul>
    <li><a href="https://www.ruby-lang.org/en/">Ruby</a></li>
  </ul>
</details>

<details>
  <summary>Server</summary>
  <ul>
    <li><a href="https://guides.rubyonrails.org/index.html">Rails</a></li>
  </ul>
</details>

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
    <li><img src="./app/assets/images/erd_diagram.png" alt="erd diagram"></li>
  </ul>
</details>

<details>
<summary>Other</summary>
  <ul>
    <li><a href="https://docs.github.com/en/get-started/quickstart/github-flow">GitHub flow</a></li>
    <li><a href="https://rubocop.org/">Rubocop</a></li>
    <li><a href="https://stylelint.io/">Stylelint</a></li>    
  </ul>
</details>

<!-- Features -->

### Key Features <a name="key-features"></a>

- **[Create category to group transactions]**
- **[Create transaction with multiple categories]**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- Project Documentation -->
## 📽️ Project Doocumentation <a name="documentation"></a>

Here is a link to the video [documentation](https://www.loom.com/share/e54c4a5ac48c4d3e91bbdb9c4cb5b0c1) of the project.

<!-- LIVE DEMO -->
## 🚀 Live Demo <a name="live-demo"></a>

- [My Budget](https://mybudget-tz8v.onrender.com/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## 💻 Getting Started <a name="getting-started"></a>

To get a local copy up and running, follow these steps.
### Setup <a name="setup"></a>
Open the terminal and clone the project
```
 git clone https://github.com/MarcoAurelioAntonio/Budget
 cd Budget-app
```

### Prerequisites <a name="prerequisites"></a>

In order to run this project you need:
`Git` and `Ruby`
```
 gem install rails
```

### Install <a name="install"></a>

Install this project with:

```sh
  bundle install
```
```sh
  npm install
```

Create Database 
 - Modify config/database.yml line 6 with your postgres password

```
  rails db:create
  rails db:migrate
  rails db:seed
```

### Run tests <a name="run-tests"></a>

```
  rspec
```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- AUTHORS -->

## 👥 Authors <a name="authors"></a>

👤 **Gustavo Porcilio**

- GitHub: [@MarcoAurelioAntonio](https://github.com/MarcoAurelioAntonio)
- Twitter: [@gustavoporcilio](https://twitter.com/gustavoporcilio)
- LinkedIn: [Gustavo Porcilio](https://www.linkedin.com/in/gustavo-porcilio-4496a223a/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FUTURE FEATURES -->

## 🔭 Future Features <a name="future-features"></a>

- [ ] **[Improve UI, maybe integrate with esbuild or webpacker]**
- [ ] **[Re-write Controllers specs]**
- [ ] **[Re-write Request specs]**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SUPPORT -->

## ⭐️ Show your support <a name="support"></a>

Give a ⭐️ if you like this project!

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGEMENTS -->

## 🙏 Acknowledgments <a name="acknowledgements"></a>

I would like to thank:
- [Diego García](https://github.com/taldr27)
- [Danys Linares](https://github.com/d4nQw3rty/)
- [Michael Mesfin](https://github.com/michael-duke)

- Under the the [Creative Commons license](https://creativecommons.org/licenses/by-nc/4.0/)

- Original design from [Gregoire Vella on Behance](https://www.behance.net/gregoirevella)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## 📝 License <a name="license"></a>

This project is [MIT](./MIT.md) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
