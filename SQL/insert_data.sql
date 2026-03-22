USE Library_db;

INSERT INTO AUTHORS (ID_AUTHOR, FIRST_NAME, LAST_NAME, EMAIL, NATIONALITY) VALUES
(1,  'Victor',       'Hugo',          'victor.hugo@litterature.fr',       'French'),
(2,  'Chinua',       'Achebe',        'chinua.achebe@africanlit.ng',       'Nigerian'),
(3,  'Gabriel',      'Garcia Marquez','garcia.marquez@literatura.co',      'Colombian'),
(4,  'Ahmadou',      'Kourouma',      'ahmadou.kourouma@litterature.ci',   'Ivorian'),
(5,  'Toni',         'Morrison',      'toni.morrison@literature.us',       'American'),
(6,  'Fyodor',       'Dostoevsky',    'fyodor.dostoevsky@literature.ru',   'Russian'),
(7,  'Ousmane',      'Sembène',       'ousmane.sembene@litterature.sn',    'Senegalese'),
(8,  'Jane',         'Austen',        'jane.austen@literature.uk',         'British'),
(9,  'Franz',        'Kafka',         'franz.kafka@literature.cz',         'Czech'),
(10, 'Mariama',      'Bâ',            'mariama.ba@litterature.sn',         'Senegalese');


INSERT INTO BOOKS (ID_BOOK, ID_AUTHOR, TITLE, PUBLISHER, YEAR_PUBLISHED, COPIES_TOTAL, COPIES_AVAILABLE) VALUES
(1,  1,  'Les Misérables',                  'Gallimard',          1862, 5, 3),
(2,  2,  'Things Fall Apart',               'Heinemann',          1958, 4, 4),
(3,  3,  'One Hundred Years of Solitude',   'Seuil',              1967, 3, 1),
(4,  4,  'The Suns of Independence',        'Présence Africaine', 1970, 6, 5),
(5,  5,  'Beloved',                         'Knopf',              1987, 3, 2),
(6,  6,  'Crime and Punishment',            'Gallimard',          1866, 4, 4),
(7,  7,  'God’s Bits of Wood',              'Présence Africaine', 1960, 5, 3),
(8,  8,  'Pride and Prejudice',             'T. Egerton',         1813, 4, 2),
(9,  9,  'The Metamorphosis',               'Gallimard',          1915, 6, 6),
(10, 10, 'So Long a Letter',                'Présence Africaine', 1979, 5, 3);


INSERT INTO MEMBERS (ID_MEMBERS, FIRST_NAME, LAST_NAME, EMAIL, PHONE, MEMBERSHIP_DATE) VALUES
(1,  'Aminata',   'Ouédraogo', 'aminata.ouedraogo@email.bf',  '+22670112233', '2024-01-15'),
(2,  'Souleymane','Traoré',    'souleymane.traore@email.bf',  '+22675223344', '2024-02-20'),
(3,  'Fatima',    'Kaboré',    'fatima.kabore@email.bf',      '+22676334455', '2024-03-10'),
(4,  'Ibrahim',   'Sawadogo',  'ibrahim.sawadogo@email.bf',   '+22677445566', '2024-04-05'),
(5,  'Mariam',    'Diallo',    'mariam.diallo@email.bf',      '+22678556677', '2024-05-18'),
(6,  'Moussa',    'Compaoré',  'moussa.compaore@email.bf',    '+22679667788', '2024-06-22'),
(7,  'Aïcha',     'Zongo',     'aicha.zongo@email.bf',        '+22670778899', '2024-07-30'),
(8,  'Hamidou',   'Bancé',     'hamidou.bance@email.bf',      '+22671889900', '2024-08-14'),
(9,  'Salimata',  'Kinda',     'salimata.kinda@email.bf',     '+22672990011', '2024-09-03'),
(10, 'Seydou',    'Barry',     'seydou.barry@email.bf',       '+22673001122', '2024-10-11');

INSERT INTO BORROWING_RECORDS (RECORD_ID, ID_BOOK, ID_MEMBERS, BORROW_DATE, DUE_DATE, RETURN_DATE) VALUES
(1,  1,  1,  '2025-01-10', '2025-01-24', '2025-01-22'),  -- returned on time
(2,  3,  2,  '2025-02-01', '2025-02-15', '2025-02-20'),  -- returned late (5 days)
(3,  5,  3,  '2025-02-10', '2025-02-24', '2025-02-24'),  -- returned exactly on time
(4,  7,  4,  '2025-03-05', '2025-03-19', '2025-03-25'),  -- returned late (6 days)
(5,  2,  5,  '2025-03-15', '2025-03-29', '2025-03-28'),  -- returned on time
(6,  8,  6,  '2025-04-01', '2025-04-15', '2025-04-20'),  -- returned late (5 days)
(7,  10, 7,  '2025-04-10', '2025-04-24', '2025-04-24'),  -- returned on time
(8,  4,  8,  '2025-05-02', '2025-05-16', '2025-05-30'),  -- returned late (14 days)
(9,  6,  9,  '2025-05-20', '2025-06-03', NULL),          -- not yet returned (ongoing)
(10, 9,  10, '2025-06-01', '2025-06-15', NULL),          -- not yet returned (ongoing)
(11, 1,  3,  '2025-06-10', '2025-06-24', '2025-06-23'),  -- returned on time
(12, 2,  6,  '2025-07-01', '2025-07-15', NULL);          -- not yet returned (ongoing)


INSERT INTO FINES (RECORD_ID, ID_MEMBERS, AMOUNT, PAID, FINE_DATE) VALUES
(2,  2,  500.00,  FALSE, '2025-02-21'),  -- 5 days x 100 FCFA, unpaid
(4,  4,  600.00,  FALSE, '2025-03-26'),  -- 6 days x 100 FCFA, unpaid
(6,  6,  500.00,  FALSE, '2025-04-21'),  -- 5 days x 100 FCFA, unpaid
(8,  8,  1400.00, FALSE, '2025-05-31');  -- 14 days x 100 FCFA, unpaid
