 #import "@preview/charged-ieee:0.1.3": ieee

#show: ieee.with(
  title: [Système de synchronisation hors ligne dans les POS avec un module IA de détection des conflits],
  abstract: [
    Les systèmes de point de vente (POS) doivent souvent fonctionner même sans connexion réseau fiable. 
    Cet article propose un état de l’art sur la synchronisation de données en mode hors ligne 
    (*offline-first*), en soulignant la problématique des conflits lors de la réintégration des 
    transactions dans la base centrale. Nous discutons ensuite de l’apport d’un module d’intelligence 
    artificielle, tel qu’un réseau bayésien, pour distinguer conflits « naturels » (mises à jour 
    concurrentes légitimes) et cas potentiellement frauduleux. Cette approche offre une résolution plus 
    fine et sécurisée, réduisant les erreurs et améliorant la confiance dans le système global.
  ],
  authors: (
    (
      name: "Neil TESSIER",
      department: [Étudiant IDIA4],
      organization: ["Université de Nantes"],
      location: ["Nantes, France"],
      email: "neil.tessier@etu.univ-nantes.fr"
    ),
  ),
  index-terms: ("Offline-first", "POS", "Synchronisation des données", "Conflits", "Réseau bayésien"),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Fig.],
)

= Introduction

Dans de nombreux secteurs du commerce, les systèmes de point de vente (*Point of Sale*, POS) doivent 
assurer la vente de produits et la gestion des stocks même lorsque la connexion réseau est absente ou 
instable. Cette approche, souvent appelée *offline-first*, consiste à enregistrer et stocker les 
transactions localement, puis à synchroniser ces données avec un serveur central aussitôt qu’une 
connexion redevient disponible. Toutefois, l’absence de mise à jour 
simultanée sur une base centrale peut engendrer des *conflits* lorsque plusieurs terminaux modifient 
indépendamment une même ressource. Les méthodes classiques (telles que *last-writer-wins*) risquent 
alors de provoquer des pertes de mises à jour légitimes ou de laisser passer des transactions 
potentiellement frauduleuses.

C’est précisément dans ce contexte que l’*intelligence artificielle* peut se révéler très utile. 
En particulier, les *réseaux bayésiens* constituent un cadre probabiliste de détection, permettant 
d’évaluer la vraisemblance qu’une transaction ou une modification concurrente soit valide ou 
frauduleuse, en se basant sur un ensemble de variables (volume, historique de ventes, localisation, 
horaires, etc.). Des travaux réalisés dans le domaine bancaire montrent que ces modèles bayésiens 
peuvent améliorer sensiblement la reconnaissance de scénarios suspects. Or, l’idée 
d’en transposer le principe aux POS offline-first est d’autant plus pertinente que ces derniers 
sont régulièrement confrontés à la question des conflits de synchronisation.

Dans cette étude, je vous propose un *état de l’art* sur la gestion de la synchronisation hors ligne 
dans les POS et la détection de conflits, en soulignant comment un module IA (réseau bayésien) 
pourrait, lors de la phase de réintégration des données, distinguer un conflit « légitime » d’une 
anomalie ou d’un acte frauduleux. Pour ce faire, je m'appuierai sur les contributions de 
German et al. (@german2016), Sai (@sai2017), Santos et Mendes (@santos2023), ainsi que Faniband 
et al. (@faniband2018), et je m'inspirerai également des approches bayésiennes de détection 
de fraude présentées par Akanbi (@akanbi2024). Je commencerai par une revue des travaux 
relevant de l’offline-first et de la sécurité dans les POS, avant de décrire comment un réseau 
bayésien peut être intégré au système pour renforcer la fiabilité de la synchronisation.

= Revue de la littérature

== Approches offline-first dans les POS <sec:offline-first>
La capacité à gérer des transactions et des mises à jour de stocks hors connexion, puis à les synchroniser 
ultérieurement, s’avère essentielle pour des points de vente situés en zones à connectivité limitée 
(@german2016). Selon Faniband et al. (@faniband2018), ce paradigme *offline-first* repose souvent sur 
des modèles de cohérence éventuelle (*eventual consistency*), où l’on tolère qu’un terminal ait une vue 
temporairement différente de l’état global, du moment que toutes les répliques convergent à terme. 

Cependant, cette logique de convergence différée peut générer des *conflits de données*. Par exemple, 
si deux caisses mobiles vendent simultanément le dernier exemplaire d’un produit, chacune croit l’avoir 
encore en stock, d’où une incohérence lors de la réintégration (@faniband2018). Les mécanismes courants 
(*last-writer-wins*, horodatage) peuvent se révéler trop simplistes : ils résolvent certes le conflit 
technique, mais ne distinguent pas un conflit « légitime » d’une fraude éventuelle.

== Sécurité et détection de fraudes dans les POS <sec:security-fraud>
Au-delà de la problématique de cohérence pure, de nombreux auteurs insistent sur les enjeux de sécurité 
des systèmes POS. Sai (@sai2017) souligne par exemple que de petites structures (PME) négligent souvent 
les contrôles de base (pare-feu, mots de passe robustes), exposant davantage le système aux manipulations 
et fraudes. Dans un contexte *offline-first*, la vigilance doit être encore accrue, puisqu’un terminal 
déconnecté peut opérer des modifications importantes sans que le serveur central en soit informé en temps réel.

Les travaux récents de Santos et Mendes (@santos2023) montrent par ailleurs comment la numérisation 
et l’*intelligence artificielle* transforment la relation entre client et point de vente : recommandation 
de produits, gestion dynamique des prix, etc. Pourtant, la détection de comportements anormaux (multiples 
ventes hors plage horaire, incohérences de stock répétées) reste un défi majeur.

== Réseaux bayésiens pour la détection des conflits et de la fraude <sec:bayes-net>
Dans le domaine bancaire, Akanbi (@akanbi2024) a montré que l’on peut exploiter les réseaux bayésiens 
pour modéliser la probabilité qu’une transaction soit frauduleuse, en se basant sur diverses variables 
(volumes, fréquences, historique de compte). Cette approche probabiliste fournit un score de crédibilité 
ou de risque, permettant de filtrer les cas suspectés d’irrégularité.

Appliqué aux POS offline-first, un *réseau bayésien* pourrait de même discriminer un conflit dû à une 
concurrence légitime (deux vendeurs encodant la vente d’un article quasiment simultanément) d’un conflit 
suspect (incohérences trop fréquentes, quantités anormalement élevées, modification de prix hors norme). 
Les solutions de synchronisation offline-first décrites par Faniband et al. (@faniband2018) ou inspirées 
par la logique CRDT se concentrent surtout sur la convergence des données, mais pas sur leur caractère 
légitime ou frauduleux.

Dans la suite, je vous propose d’allier ces deux perspectives : utiliser un mécanisme de synchronisation 
offline-first pour garantir la continuité d’activité, et y adosser un module IA (réseau bayésien) chargé 
d’estimer la probabilité qu’une mise à jour concurrente soit légitime ou suspecte. Cette intégration 
permettrait alors de classer les conflits et de déclencher des procédures différentes (fusion automatique, 
alerte, validation manuelle) en fonction du risque évalué.

= Approche proposée

== Architecture globale du système <sec:architecture>
Dans notre scénario, chaque terminal de point de vente (*POS*) conserve localement les transactions 
(historique de ventes, mises à jour de stocks) tant qu’il demeure hors connexion. Dès que la 
connexion est rétablie, une synchronisation asynchrone (*batch* ou progressive) envoie ces 
modifications vers le serveur central. Celui-ci met alors à jour l’ensemble des données et notifie 
les autres terminaux, assurant la convergence des états.  

Cependant, à l’issue de cette opération, le serveur peut détecter un *conflit* (plusieurs 
modifications concurrentes sur le même produit, etc.). Plutôt que d’appliquer une simple règle 
*last-writer-wins*, je vous propose d’intégrer un *module IA* (basé sur un réseau bayésien) pour 
analyser la probabilité que chaque conflit soit « naturel » ou « suspect ».  

== Réseau bayésien pour la détection de conflits <sec:bayes>
Inspirés par l’approche d’Akanbi (@akanbi2024) dans la détection de fraude bancaire, je vous propose 
un réseau bayésien capable d’agréger divers *indicateurs* comme :

1. *Historique de ventes* (quantité déjà vendue, pics inhabituels)  
2. *Heure et date* de la modification (ventes à des horaires improbables?)  
3. *Fiabilité du terminal* (ex. taux d’erreurs passées, fréquences de réclamations)  
4. *Valeurs relatives* (ex. stock avant vs. stock après, différence de prix)  

Chaque nœud du réseau est associé à une *variable* (par exemple, un score de crédibilité du 
terminal), et le réseau encode les *relations de dépendance* ou d’indépendance conditionnelle 
entre ces variables. Lorsqu’un conflit survient, le modèle calcule une *probabilité de fraude* ou 
une *probabilité de conflit légitime*. Selon ce score, on applique différentes stratégies :

- *Faible suspicion* : on fusionne automatiquement les modifications (conflit classé « normal »).  
- *Suspicion moyenne* : on demande la validation d’un gestionnaire (alerte visuelle sur le 
  back-office).  
- *Suspicion élevée* : blocage temporaire des transactions concernées, éventuellement 
  désactivation du terminal en cause.

== Intégration dans le flux de synchronisation <sec:integration>
Concrètement, lors de la phase de réintégration :  
1. Les *transactions hors ligne* sont envoyées du terminal vers le serveur.  
2. Le serveur applique une *détection de conflits* basique (repérage de champs modifiés en parallèle).  
3. Pour chaque conflit détecté, le *réseau bayésien* reçoit un ensemble de variables (ex. timestamp, 
  identifiant du terminal, stock précédent, etc.) et calcule la *probabilité de fraude*.  
4. Selon un *seuil* de confiance prédéfini, le serveur décide d’accepter, de rejeter ou de demander 
  l’approbation humaine.
Cette architecture permet de conserver la *simplicité* d’une synchronisation offline-first (accès 
local, batch quand la connexion revient) tout en y intégrant un *contrôle plus fin* des conflits, 
réduisant les risques de pertes de ventes légitimes ou de validation de transactions frauduleuses.

= Discussion

== Avantages et efficacité <sec:avantages>
En combinant une approche *offline-first* pour la gestion des transactions POS et un module d’intelligence 
artificielle reposant sur un réseau bayésien, on obtient deux bénéfices majeurs :

1. *Réduction des conflits ignorés*. Plutôt que de s’en remettre à une politique d’écrasement 
   (*last-writer-wins*), la détection probabiliste des scénarios suspects permet de mieux préserver 
   les mises à jour légitimes, en discriminant un simple décalage temporel d’une fraude potentielle.

2. *Gain de sécurité*. L’IA offre un mécanisme d’alerte sur les incohérences anormales ; cela 
   renforce le contrôle, notamment dans des structures peu dotées en moyens de cybersécurité 
   (@sai2017). En outre, l’apprentissage du réseau bayésien peut progressivement s’améliorer 
   grâce aux retours sur les cas de fraude avérés (processus itératif).

== Limites et challenges <sec:limites>
Malgré ses atouts, la solution proposée présente plusieurs limites :

- *Complexité de mise en œuvre*. Comparé à un simple script de synchronisation, le déploiement 
  d’un réseau bayésien exige de bien définir les variables, de récolter des données de qualité 
  (historiques de ventes, logs d’erreurs, etc.) et de maintenir un modèle à jour (@akanbi2024).
- *Performance en situation réelle*. Selon la taille du réseau et le volume de données hors 
  ligne, le temps de calcul peut s’avérer non négligeable lors de la réintégration. Des optimisations, 
  comme un traitement incrémental ou un filtrage préliminaire, peuvent être nécessaires.
- *Risques de faux positifs*. Même un bon modèle probabiliste peut déclarer frauduleuse une 
  vente légitime, ce qui impose une gestion manuelle supplémentaire (Santos & Mendes, @santos2023). 
  Le choix des seuils de suspicion doit être adapté au contexte (ex. taille du magasin, 
  historique d’incidents).

== Comparaison avec d’autres méthodes <sec:comparaison>
Les CRDT (Conflict-Free Replicated Data Types) (@faniband2018) constituent une autre solution pour 
assurer la *convergence automatique* des données distribuées, en évitant la plupart des conflits 
structurels. Néanmoins, ils ne traitent pas l’aspect « fraude ». L’IA proposée ici vient justement 
combler cette lacune en évaluant l’intention (ou la plausibilité) des mises à jour, plutôt que de 
simplement les fusionner de façon neutre.

De même, des règles statiques de validation (ex. interdiction de dépasser un certain montant) sont 
simples mais peu adaptatives. Le recours à un réseau bayésien élargit la prise en compte de variables 
contextuelles et évolutives (historique, fiabilité de l’appareil, etc.). Akanbi (@akanbi2024) 
souligne à cet égard la robustesse des approches bayésiennes pour agréger des données hétérogènes 
tout en fournissant un score clair de probabilité.

== Synthèse de la discussion <sec:synthèse-discussion>
En somme, l’intégration d’un réseau bayésien dans la synchronisation *offline-first* des POS présente 
un compromis *coût/bénéfice* prometteur. Le coût se mesure en complexité de mise en place et en 
ressources de calcul ; le bénéfice se concrétise dans une meilleure protection contre les fraudes et 
une résolution de conflits plus fine. Les scénarios réels de déploiement devront toutefois confirmer 
l’adéquation de la solution (maintenance, ajustement des seuils), mais les perspectives offertes 
paraissent solides pour de nombreuses enseignes et PME.

= Conclusion et perspectives

Dans cet état de l’art, j'ai mis en lumière l’importance d’un *système de synchronisation 
offline-first* dans les points de vente (POS), tout en soulignant les risques de conflits et de 
fraudes potentielles lorsqu’un terminal hors ligne réintègre ses données dans la base centrale. 
L’analyse de la littérature montre que si des approches telles que *last-writer-wins* ou les *CRDT* 
(@faniband2018) répondent partiellement au besoin de cohérence, elles ne traitent pas suffisamment 
le volet fraude. En intégrant un *réseau bayésien* pour discriminer les conflits légitimes des 
anomalies suspectes, on améliore sensiblement la fiabilité du système. Inspirée, entre autres, par les 
travaux d’Akanbi (@akanbi2024) dans le secteur bancaire, cette proposition souligne la pertinence 
d’une approche probabiliste pour évaluer le risque de fraude dans un contexte offline-first.

La *mise en œuvre* d’un tel module IA implique néanmoins une démarche rigoureuse : définition 
précise des variables (historique de ventes, fiabilité du terminal, heure de transaction, etc.), 
collecte et maintien d’un grand volume de données historiques, entraînement et réajustement 
régulier du réseau bayésien. Sur le plan opérationnel, le choix des *seuils* de suspicion demeure 
un point stratégique, afin de limiter les faux positifs qui pénaliseraient la fluidité des opérations.

== Perspectives
1. *Validation en conditions réelles* : tester l’approche dans plusieurs enseignes (taille, répartition 
  géographique) pour évaluer les bénéfices concrets en termes de détection de fraude 
2. *Couplage avec d’autres algorithmes* : au-delà du réseau bayésien, des techniques de *machine 
  learning* supervisé (réseaux neuronaux, SVM) pourraient être explorées, notamment pour repérer 
  des anomalies comportementales plus fines (@santos2023).
3. *Outils et plateformes* : envisager l’emploi de frameworks open-source (ex. PouchDB, 
  CouchDB pour la partie offline-first) et de bibliothèques Python/JS pour la partie IA, 
  optimisant ainsi le développement et la maintenance.
4. *Apprentissage continu* : mettre en place un mécanisme d’auto-amélioration, où chaque nouveau 
  cas détecté (conflit avéré ou fraude confirmée) vient affiner les paramètres du modèle probabiliste.

== Usage intensif de l’IA dans ce travail
J'ai fait *massivement* appel à l’intelligence artificielle pour produire ce document de bout 
en bout. *Toutes* les sources bibliographiques ont été *repérées* via des requêtes assistées par 
un LLM, *l’intégralité* du texte a d’abord été *rédigée* par 
l’IA, puis *restructurée et corrigée* par mes soins. Bien sûr, j’ai effectué une *vérification 
humaine* rigoureuse de chaque référence et de chaque affirmation, afin de veiller à la cohérence 
et à la pertinence scientifique du contenu. 

Ce choix assumé d’utiliser l’IA à toutes les étapes—depuis la recherche documentaire jusqu’à la 
rédaction initiale—m’a permis de gagner un temps considérable, tout en identifiant des *mots-clés* 
et des *axes* parfois inattendus. Cela ne s’est toutefois pas fait au détriment de mon esprit 
critique : j’ai *filtré*, *validé* et parfois *réécrit* certaines sections pour m’assurer 
que le texte final reflète fidèlement les enjeux et les nuances du sujet. Dans l’ensemble, cette 
démarche illustre la *puissance* de l’IA pour accélérer le travail académique, à condition de la 
coupler à une *relecture* et une *analyse* humaines.

En conclusion, le *mariage d’une architecture offline-first* et d’un *module IA* de détection 
des conflits/fraudes apporte une plus-value notable, surtout pour des commerces vulnérables aux 
perturbations réseau et aux tentatives de malversation. Les résultats de la littérature indiquent que 
cette solution est prometteuse, mais mérite des validations empiriques plus approfondies, dans des 
contextes métier variés et au fil de l’évolution des comportements malveillants.