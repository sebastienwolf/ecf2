-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : jeu. 30 juin 2022 à 11:18
-- Version du serveur : 8.0.29-0ubuntu0.20.04.3
-- Version de PHP : 8.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `comparator`
--

-- --------------------------------------------------------

--
-- Structure de la table `answer`
--

CREATE TABLE `answer` (
  `id` int UNSIGNED NOT NULL,
  `position` int NOT NULL,
  `label` varchar(255) NOT NULL,
  `question_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `answer`
--

INSERT INTO `answer` (`id`, `position`, `label`, `question_id`) VALUES
(7, 1, 'Gestion d\'une boutique en ligne de goodies ou d\'autres produit', 3),
(8, 2, 'Réception des paiements, crowdfunding, gestion des adhésions et des dons', 3),
(9, 3, 'Logiciel tout en un', 3),
(10, 4, 'Logiciel de comptabilité pour association', 3),
(11, 1, 'Sportive', 5),
(12, 3, 'culturelle', 5),
(13, 6, 'caritative', 5),
(14, 2, 'politique', 5),
(15, 7, 'Etudiante', 5),
(16, 5, 'Etudiante', 5),
(17, 4, 'professionnelle', 5),
(18, 1, 'Moins de 50 membres', 2),
(19, 2, 'Entre 51 et 200 membres', 2),
(20, 4, 'Entre 201 et 1000 membres', 2),
(21, 3, 'Plus de 1000 membres', 2),
(22, 1, 'Oui', 4),
(23, 2, 'Non', 4),
(24, 2, 'Non', 1),
(25, 1, 'Oui', 1);

-- --------------------------------------------------------

--
-- Structure de la table `answer_has_solution`
--

CREATE TABLE `answer_has_solution` (
  `answer_id` int UNSIGNED NOT NULL,
  `solution_id` int UNSIGNED NOT NULL,
  `score` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `answer_has_solution`
--

INSERT INTO `answer_has_solution` (`answer_id`, `solution_id`, `score`) VALUES
(7, 1, 10),
(7, 2, 100),
(7, 3, 1),
(8, 1, 10),
(8, 2, 2),
(8, 3, 1),
(9, 1, 10),
(9, 2, 2),
(9, 3, 1),
(10, 1, 10),
(10, 2, 2),
(10, 3, 1),
(11, 1, 10),
(11, 2, 2),
(11, 3, 1),
(12, 1, 10),
(12, 2, 2),
(12, 3, 1),
(13, 1, 10),
(13, 2, 2),
(13, 3, 1),
(14, 1, 10),
(14, 2, 2),
(14, 3, 1),
(15, 1, 10),
(15, 2, 2),
(15, 3, 1),
(16, 1, 10),
(16, 2, 2),
(16, 3, 1),
(17, 1, 10),
(17, 2, 2),
(17, 3, 1),
(18, 1, 10),
(18, 2, 2),
(18, 3, 1),
(19, 1, 10),
(19, 2, 2),
(19, 3, 1),
(20, 1, 10),
(20, 2, 2),
(20, 3, 1),
(21, 1, 10),
(21, 2, 2),
(21, 3, 1),
(22, 1, 10),
(22, 2, 2),
(22, 3, 1),
(23, 1, 10),
(23, 2, 2),
(23, 3, 1),
(24, 1, 10),
(24, 2, 2),
(24, 3, 1),
(25, 1, 10),
(25, 2, 2),
(25, 3, 1);

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

CREATE TABLE `category` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(75) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=big5;

--
-- Déchargement des données de la table `category`
--

INSERT INTO `category` (`id`, `name`) VALUES
(1, 'general'),
(2, 'test');

-- --------------------------------------------------------

--
-- Structure de la table `question`
--

CREATE TABLE `question` (
  `id` int UNSIGNED NOT NULL,
  `position` int NOT NULL,
  `label` varchar(255) NOT NULL,
  `coefficient` int NOT NULL,
  `category_id` int UNSIGNED NOT NULL,
  `type_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `question`
--

INSERT INTO `question` (`id`, `position`, `label`, `coefficient`, `category_id`, `type_id`) VALUES
(1, 5, 'Avez-vous besoin d\'envoyer des emails ?', 2, 1, 1),
(2, 3, 'Combien de membres souhaitez-vous gérer sur le logiciel ?', 1, 1, 2),
(3, 2, 'Quel sera votre principale utilisation de votre logiciel pour association ?', 1, 1, 1),
(4, 4, 'Avez-vous besoin d\'un éditeur de site internet ?', 1, 1, 1),
(5, 1, 'Quel est le profil de votre association ?', 3, 1, 1),
(6, 1, 'À ne pas prendre cette question', 10, 2, 1);

-- --------------------------------------------------------

--
-- Structure de la table `solution`
--

CREATE TABLE `solution` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(75) NOT NULL,
  `logo_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `site_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `solution`
--

INSERT INTO `solution` (`id`, `name`, `logo_url`, `site_url`, `description`) VALUES
(1, 'Pep\'s UP', 'https://www.pepsup.com/resources/common/images/logo/ligne_lc_60.png', 'https://www.pepsup.com/', '        <h3>Pourquoi Pep\'s UP</h3>        <p> Pep\'s Up est un logiciel de gestion d\'association très complet avec différents            modules : gestion des membres et des adhésions, billetterie, communication et comptabilité </p>        <p>            Le logiciel est également réputé pour la qualité de son accompagnement (onboarding, ressources            en            ligne, réactivité du service client) et son prix compétitif.        </p>        <p>            Pep\'s Up est, selon nous, une valeur sûre parmi les logiciels de gestion d\'association. En plus            de            ses fonctionnalités, on apprécie particulièrement la place centrale faite aux utilisateurs dans            l\'évolution du logiciel.        </p>        <p>            Le logiciel propose un essai gratuit de 30 jours        </p>        <a id=\"siteUrl\" href=\"https://www.pepsup.com/\">Visiter leur site</a>'),
(2, 'helloasso', 'https://asso.compta.com/wp-content/uploads/2019/10/Logo-vertical-bleu.png', 'https://www.helloasso.com/associations', '<h3>Pourquoi HelloAsso ?</h3><p> HelloAsso est un logiciel entièrement gratuit, y compris pour les frais de paiement qui sont inexistants    contrairement aux autres logiciels. Nous conseillons HelloAsso lorsque vous recherchez le logiciel le moins cher du    marché ou avec le meilleur rapport qualité/prix.</p><p>    Si vous avez besoin de plus de fonctionnalités que ce que peut vous offrir HelloAsso, essayez AssoConnect qui est un    logiciel plus complet.</p>'),
(3, 'AssoConnect', 'https://web-assoconnect-frc-prod-cdn-endpoint-showcase.azureedge.net/common/logo/assoconnect.svg', 'https://www.welcome-ohme.fr/', '<h3>Pourquoi AssoConnect ?</h3><p>    AssoConnect est le leader des logiciels de gestion d\'association en France. L\'entreprise parisienne propose le    logiciel le plus complet du marché avec de nombreuses fonctionnalités, une grande facilité d\'utilisation et un    design moderne.</p><p>    Le logiciel vous permet de gérer vos membres, vos adhésions, vos collectes de dons, votre billetterie, une boutique    en ligne et votre comptabilité. Vous pouvez également gérer votre communication depuis votre logiciel : emailing et    site internet.</p><p>    Nous vous recommandons AssoConnect les yeux fermés puisque le logiciel possède une des meilleures réputations du    marché et un accompagnement de grande qualité \"malgré\" ses 20 000 associations clientes.</p>');

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

CREATE TABLE `type` (
  `id` int UNSIGNED NOT NULL,
  `label` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `type`
--

INSERT INTO `type` (`id`, `label`) VALUES
(1, 'radio'),
(2, 'checkbox');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `answer`
--
ALTER TABLE `answer`
  ADD PRIMARY KEY (`id`,`question_id`),
  ADD KEY `fk_answer_question1_idx` (`question_id`);

--
-- Index pour la table `answer_has_solution`
--
ALTER TABLE `answer_has_solution`
  ADD PRIMARY KEY (`answer_id`,`solution_id`),
  ADD KEY `fk_answer_has_solution_solution1_idx` (`solution_id`),
  ADD KEY `fk_answer_has_solution_answer1_idx` (`answer_id`);

--
-- Index pour la table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id`,`category_id`),
  ADD KEY `fk_question_category1_idx` (`category_id`),
  ADD KEY `fk_question_type` (`type_id`);

--
-- Index pour la table `solution`
--
ALTER TABLE `solution`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `answer`
--
ALTER TABLE `answer`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `category`
--
ALTER TABLE `category`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `question`
--
ALTER TABLE `question`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `solution`
--
ALTER TABLE `solution`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `answer`
--
ALTER TABLE `answer`
  ADD CONSTRAINT `fk_answer_question1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`);

--
-- Contraintes pour la table `answer_has_solution`
--
ALTER TABLE `answer_has_solution`
  ADD CONSTRAINT `fk_answer_has_solution_answer1` FOREIGN KEY (`answer_id`) REFERENCES `answer` (`id`),
  ADD CONSTRAINT `fk_answer_has_solution_solution1` FOREIGN KEY (`solution_id`) REFERENCES `solution` (`id`);

--
-- Contraintes pour la table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `fk_question_category1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `fk_question_type` FOREIGN KEY (`type_id`) REFERENCES `type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

-- -----------------------------------------------------
-- Table `comparateurPlus`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comparateurPlus`.`users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `mail` VARCHAR(100) NOT NULL,
  `password` VARCHAR(255) COLLATE 'Default Collation' NOT NULL,
  `type` VARCHAR(45) COLLATE 'Default Collation' NOT NULL,
  PRIMARY KEY (`id`))
 ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
