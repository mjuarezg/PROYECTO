SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Provincia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Provincia` (
  `id` INT NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sector`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Sector` (
  `id` INT NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuariobasico`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Usuariobasico` (
  `clave` VARCHAR(45) NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  `apellidos` VARCHAR(45) NOT NULL ,
  `fechaNacimiento` DATE NOT NULL ,
  `email` VARCHAR(45) NULL ,
  `foto` VARCHAR(45) NULL ,
  `telefono` INT NULL ,
  `administrador` TINYINT(1) NOT NULL ,
  `provincia_id` INT NOT NULL ,
  `sector_id` INT NOT NULL ,
  `id` VARCHAR(45) NOT NULL ,
  INDEX `fk_Usuario basico_Provincia_idx` (`provincia_id` ASC) ,
  INDEX `fk_Usuario basico_sector1_idx` (`sector_id` ASC) ,
  PRIMARY KEY (`id`) ,
  CONSTRAINT `fk_Usuario basico_Provincia`
    FOREIGN KEY (`provincia_id` )
    REFERENCES `mydb`.`Provincia` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario basico_sector1`
    FOREIGN KEY (`sector_id` )
    REFERENCES `mydb`.`Sector` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MUsuarioAUsuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`MUsuarioAUsuario` (
  `titulo` VARCHAR(45) NOT NULL ,
  `contenido` VARCHAR(45) NOT NULL ,
  `fechaEnvio` DATE NOT NULL ,
  `privado` TINYINT(1) NOT NULL ,
  `leido` TINYINT(1) NOT NULL ,
  `id` INT NOT NULL ,
  `emisor` VARCHAR(45) NOT NULL ,
  `receptor` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`, `emisor`, `receptor`) ,
  INDEX `fk_MUsuarioAUsuario_Usuariobasico1_idx` (`emisor` ASC) ,
  INDEX `fk_MUsuarioAUsuario_Usuariobasico2_idx` (`receptor` ASC) ,
  CONSTRAINT `fk_MUsuarioAUsuario_Usuariobasico1`
    FOREIGN KEY (`emisor` )
    REFERENCES `mydb`.`Usuariobasico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MUsuarioAUsuario_Usuariobasico2`
    FOREIGN KEY (`receptor` )
    REFERENCES `mydb`.`Usuariobasico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empresa`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Empresa` (
  `id` VARCHAR(45) NOT NULL ,
  `clave` VARCHAR(45) NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  `direccion` VARCHAR(45) NOT NULL ,
  `foto` VARCHAR(45) NULL ,
  `telefono` INT NULL ,
  `email` VARCHAR(45) NULL ,
  `provincia_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Empresa_Provincia1_idx` (`provincia_id` ASC) ,
  CONSTRAINT `fk_Empresa_Provincia1`
    FOREIGN KEY (`provincia_id` )
    REFERENCES `mydb`.`Provincia` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Oferta`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Oferta` (
  `id` INT NOT NULL ,
  `titulo` VARCHAR(45) NOT NULL ,
  `descripcion` VARCHAR(500) NOT NULL ,
  `fechaPublicacion` DATE NOT NULL ,
  `abierta` TINYINT(1) NOT NULL ,
  `salario` INT NULL ,
  `jornada` VARCHAR(45) NULL ,
  `contrato` VARCHAR(45) NULL ,
  `empresa_id` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_Oferta_Empresa1_idx` (`empresa_id` ASC) ,
  CONSTRAINT `fk_Oferta_Empresa1`
    FOREIGN KEY (`empresa_id` )
    REFERENCES `mydb`.`Empresa` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Candidato`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Candidato` (
  `usuariobasico_id` VARCHAR(45) NOT NULL ,
  `oferta_id` INT NOT NULL ,
  `fechaInscripcion` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`oferta_id`) ,
  INDEX `fk_Usuario basico_has_Oferta_Oferta1_idx` (`oferta_id` ASC) ,
  INDEX `fk_Usuario basico_has_Oferta_Usuario basico1_idx` (`usuariobasico_id` ASC) ,
  CONSTRAINT `fk_Usuario basico_has_Oferta_Usuario basico1`
    FOREIGN KEY (`usuariobasico_id` )
    REFERENCES `mydb`.`Usuariobasico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario basico_has_Oferta_Oferta1`
    FOREIGN KEY (`oferta_id` )
    REFERENCES `mydb`.`Oferta` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Seleccionado`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Seleccionado` (
  `usuariobasico_id` VARCHAR(45) NOT NULL ,
  `oferta_id` INT NOT NULL ,
  `empresa_id` VARCHAR(45) NOT NULL ,
  `fechaSeleccion` DATE NOT NULL ,
  `puntuacion` INT NULL ,
  `comentario` VARCHAR(45) NULL ,
  PRIMARY KEY (`usuariobasico_id`, `oferta_id`, `empresa_id`) ,
  INDEX `fk_Candidatos_has_Empresa_Empresa1_idx` (`empresa_id` ASC) ,
  INDEX `fk_Candidatos_has_Empresa_Candidatos1_idx` (`usuariobasico_id` ASC, `oferta_id` ASC) ,
  CONSTRAINT `fk_Candidatos_has_Empresa_Candidatos1`
    FOREIGN KEY (`usuariobasico_id` , `oferta_id` )
    REFERENCES `mydb`.`Candidato` (`usuariobasico_id` , `oferta_id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Candidatos_has_Empresa_Empresa1`
    FOREIGN KEY (`empresa_id` )
    REFERENCES `mydb`.`Empresa` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`timestamps`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`timestamps` (
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
  `update_time` TIMESTAMP NULL );


-- -----------------------------------------------------
-- Table `mydb`.`MEmpresaAUsuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`MEmpresaAUsuario` (
  `titulo` VARCHAR(45) NOT NULL ,
  `contenido` VARCHAR(45) NOT NULL ,
  `fechaEnvio` DATE NOT NULL ,
  `privado` TINYINT(1) NOT NULL ,
  `leido` TINYINT(1) NOT NULL ,
  `id` INT NOT NULL ,
  `emisor` VARCHAR(45) NOT NULL ,
  `receptor` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`, `emisor`, `receptor`) ,
  INDEX `fk_Mensaje_copy1_Empresa1_idx` (`emisor` ASC) ,
  INDEX `fk_MEmpresaAUsuario_Usuariobasico1_idx` (`receptor` ASC) ,
  CONSTRAINT `fk_Mensaje_copy1_Empresa1`
    FOREIGN KEY (`emisor` )
    REFERENCES `mydb`.`Empresa` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MEmpresaAUsuario_Usuariobasico1`
    FOREIGN KEY (`receptor` )
    REFERENCES `mydb`.`Usuariobasico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MUsuarioAEmpresa`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`MUsuarioAEmpresa` (
  `titulo` VARCHAR(45) NOT NULL ,
  `contenido` VARCHAR(45) NOT NULL ,
  `fechaEnvio` DATE NOT NULL ,
  `privado` TINYINT(1) NOT NULL ,
  `leido` TINYINT(1) NOT NULL ,
  `id` INT NOT NULL ,
  `emisor` VARCHAR(45) NOT NULL ,
  `receptor` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`, `emisor`, `receptor`) ,
  INDEX `fk_Mensaje_copy2_Usuariobasico1_idx` (`emisor` ASC) ,
  INDEX `fk_MUsuarioAEmpresa_Empresa1_idx` (`receptor` ASC) ,
  CONSTRAINT `fk_Mensaje_copy2_Usuariobasico1`
    FOREIGN KEY (`emisor` )
    REFERENCES `mydb`.`Usuariobasico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MUsuarioAEmpresa_Empresa1`
    FOREIGN KEY (`receptor` )
    REFERENCES `mydb`.`Empresa` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MEmpresaaEmpresa`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`MEmpresaaEmpresa` (
  `titulo` VARCHAR(45) NOT NULL ,
  `contenido` VARCHAR(45) NOT NULL ,
  `fechaEnvio` DATE NOT NULL ,
  `privado` TINYINT(1) NOT NULL ,
  `leido` TINYINT(1) NOT NULL ,
  `id` INT NOT NULL ,
  `emisor` VARCHAR(45) NOT NULL ,
  `receptor` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`, `emisor`, `receptor`) ,
  INDEX `fk_Mensaje_copy3_Empresa1_idx` (`emisor` ASC) ,
  INDEX `fk_MEmpresaaEmpresa_Empresa1_idx` (`receptor` ASC) ,
  CONSTRAINT `fk_Mensaje_copy3_Empresa1`
    FOREIGN KEY (`emisor` )
    REFERENCES `mydb`.`Empresa` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MEmpresaaEmpresa_Empresa1`
    FOREIGN KEY (`receptor` )
    REFERENCES `mydb`.`Empresa` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Curriculum`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Curriculum` (
  `nombre` VARCHAR(45) NULL ,
  `fechaSubida` DATE NOT NULL ,
  `ubicacion` VARCHAR(50) NOT NULL ,
  `usuariobasico_id` VARCHAR(45) NOT NULL ,
  UNIQUE INDEX `ubicacion_UNIQUE` (`ubicacion` ASC) ,
  PRIMARY KEY (`usuariobasico_id`) ,
  CONSTRAINT `fk_Curriculum_Usuariobasico1`
    FOREIGN KEY (`usuariobasico_id` )
    REFERENCES `mydb`.`Usuariobasico` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
