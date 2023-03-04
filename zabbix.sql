INSERT INTO `users` (`userid`, `username`, `name`, `surname`, `passwd`, `url`, `autologin`, `autologout`, `lang`, `refresh`, `theme`, `attempt_failed`, `attempt_ip`, `attempt_clock`, `rows_per_page`, `timezone`, `roleid`) 
VALUES
    (1, 't2web', 'noc', 'noc', '$2y$10$Ny1AMWHVdRvaubj98RyyNu3HWUrnMgygHPVXdeHqXKF8AENywfYJC', '', 1, '0', 'default', '30s', 'default', 0, '', 0, 50, 'default', 3),
    (2, 'guest', '', '', '$2y$10$89otZrRNmde97rIyzclecuk6LwKAsHN0BcvoOKGjbT.BwMBfm7G06', '', 0, '15m', 'default', '30s', 'default', 0, '', 0, 50, 'default', 4),
    (3, 't2bot', 'bot', 'bot', '$2y$10$8RUtVkFP0UZaLIilY1rGLejKf.WpPln/GucIm/wmYcQ3vrjSyAvhO', '', 0, '0', 'default', '30s', 'default', 0, '', 0, 50, 'default', 3),
    (4, 'grafana', 'grafana', 'grafana', '$2y$10$DpfcznHlwFi2K.d4lcLkrOtGa95cKBHT5KL.Smj8YJIo8S2j7yZXW', '', 0, '0', 'default', '30s', 'default', 0, '', 0, 50, 'default', 3)
ON DUPLICATE KEY UPDATE 
    `username` = VALUES(`username`),
    `name` = VALUES(`name`),
    `surname` = VALUES(`surname`),
    `passwd` = VALUES(`passwd`),
    `url` = VALUES(`url`),
    `autologin` = VALUES(`autologin`),
    `autologout` = VALUES(`autologout`),
    `lang` = VALUES(`lang`),
    `refresh` = VALUES(`refresh`),
    `theme` = VALUES(`theme`),
    `attempt_failed` = VALUES(`attempt_failed`),
    `attempt_ip` = VALUES(`attempt_ip`),
    `attempt_clock` = VALUES(`attempt_clock`),
    `rows_per_page` = VALUES(`rows_per_page`),
    `timezone` = VALUES(`timezone`),
    `roleid` = VALUES(`roleid`);

UPDATE `config`
SET `default_theme` = 'dark-theme', `default_lang` = 'pt_BR'
WHERE `configid` = 1;