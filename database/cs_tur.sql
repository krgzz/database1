USE [master]
GO
/****** Object:  Database [CS_TUR]    Script Date: 22.05.2022 19:27:23 ******/
CREATE DATABASE [CS_TUR]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CS_TUR', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CS_TUR.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CS_TUR_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CS_TUR_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CS_TUR] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CS_TUR].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CS_TUR] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CS_TUR] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CS_TUR] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CS_TUR] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CS_TUR] SET ARITHABORT OFF 
GO
ALTER DATABASE [CS_TUR] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CS_TUR] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CS_TUR] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CS_TUR] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CS_TUR] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CS_TUR] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CS_TUR] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CS_TUR] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CS_TUR] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CS_TUR] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CS_TUR] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CS_TUR] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CS_TUR] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CS_TUR] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CS_TUR] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CS_TUR] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CS_TUR] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CS_TUR] SET RECOVERY FULL 
GO
ALTER DATABASE [CS_TUR] SET  MULTI_USER 
GO
ALTER DATABASE [CS_TUR] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CS_TUR] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CS_TUR] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CS_TUR] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CS_TUR] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CS_TUR] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CS_TUR', N'ON'
GO
ALTER DATABASE [CS_TUR] SET QUERY_STORE = OFF
GO
USE [CS_TUR]
GO
/****** Object:  Table [dbo].[rezervasyonlar]    Script Date: 22.05.2022 19:27:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rezervasyonlar](
	[rezervasyon_id] [int] NOT NULL,
	[rezervasyon_adi] [nvarchar](50) NOT NULL,
	[rezervasyon_yapan_ad_soyad] [nvarchar](50) NOT NULL,
	[rezervasyon_sorumlusu] [nvarchar](50) NOT NULL,
	[araca_binecegi_yer] [nvarchar](50) NOT NULL,
	[rezervasyon_tarihi] [date] NOT NULL,
	[iletisim_numarasi] [int] NOT NULL,
	[rezervasyon_yili] [int] NOT NULL,
 CONSTRAINT [PK_rezervasyonlar] PRIMARY KEY CLUSTERED 
(
	[rezervasyon_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[rezervasyonTarihi]    Script Date: 22.05.2022 19:27:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[rezervasyonTarihi] (
    @tur_yili INT
)
RETURNS TABLE
AS
RETURN
    SELECT 
        rezervasyon_id,
        rezervasyon_adi,
        rezervasyon_yapan_ad_soyad,
		rezervasyon_sorumlusu,
		araca_binecegi_yer,
		rezervasyon_tarihi,
		rezervasyon_yili
		
    FROM
        rezervasyonlar
    WHERE
        rezervasyon_yili = @tur_yili;
GO
/****** Object:  Table [dbo].[musteriler]    Script Date: 22.05.2022 19:27:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[musteriler](
	[musteri_id] [int] NOT NULL,
	[musteri_ad_soyad] [nvarchar](60) NOT NULL,
	[musteri_adresi] [nvarchar](300) NOT NULL,
	[musteri_tel_no] [nvarchar](14) NOT NULL,
	[musteri_tc_kimlik_no] [nvarchar](11) NOT NULL,
 CONSTRAINT [PK_musteriler] PRIMARY KEY CLUSTERED 
(
	[musteri_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[mus_rezerv]    Script Date: 22.05.2022 19:27:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[mus_rezerv]
AS
SELECT        TOP (100) PERCENT dbo.musteriler.musteri_id, dbo.musteriler.musteri_tel_no, dbo.rezervasyonlar.rezervasyon_yili
FROM            dbo.musteriler INNER JOIN
                         dbo.rezervasyonlar ON dbo.musteriler.musteri_id = dbo.rezervasyonlar.rezervasyon_id
ORDER BY dbo.rezervasyonlar.rezervasyon_id
GO
/****** Object:  Table [dbo].[araclar]    Script Date: 22.05.2022 19:27:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[araclar](
	[arac_id] [int] NOT NULL,
	[arac_marka_model] [nvarchar](50) NULL,
	[arac_plaka] [nvarchar](7) NULL,
	[arac_kapasitesi] [int] NULL,
 CONSTRAINT [PK_araclar] PRIMARY KEY CLUSTERED 
(
	[arac_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[banka_hesaplari]    Script Date: 22.05.2022 19:27:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[banka_hesaplari](
	[banka_id] [int] NOT NULL,
	[banka_adi] [nvarchar](60) NULL,
	[banka_sube_kodu] [int] NULL,
	[banka_sube_adi] [nvarchar](50) NULL,
	[banka_hesap_no] [int] NULL,
	[banka_hesap_iban] [nvarchar](26) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[odeme_yontemleri]    Script Date: 22.05.2022 19:27:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[odeme_yontemleri](
	[odeme_id] [int] NOT NULL,
	[odeme_adi] [nvarchar](50) NULL,
	[odeme_methodu] [nvarchar](50) NULL,
 CONSTRAINT [PK_odeme_yontemleri] PRIMARY KEY CLUSTERED 
(
	[odeme_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[oteller]    Script Date: 22.05.2022 19:27:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[oteller](
	[otel_id] [int] NOT NULL,
	[otel_adi] [nvarchar](50) NOT NULL,
	[oda_sayisi] [int] NOT NULL,
	[otel_adresi] [nvarchar](300) NULL,
	[otel_iletisim_no] [nvarchar](14) NULL,
	[gecelik_ucret] [int] NOT NULL,
 CONSTRAINT [PK_oteller] PRIMARY KEY CLUSTERED 
(
	[otel_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[personel]    Script Date: 22.05.2022 19:27:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[personel](
	[id] [int] NOT NULL,
	[personel_adi_soyadi] [nvarchar](60) NOT NULL,
	[personel_ev_adresi] [nvarchar](300) NOT NULL,
	[personel_iletisim_no] [nvarchar](14) NOT NULL,
	[yaka] [nvarchar](2) NOT NULL,
 CONSTRAINT [PK_personel] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subeler]    Script Date: 22.05.2022 19:27:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subeler](
	[sube_id] [int] NOT NULL,
	[sube_adi] [nvarchar](50) NOT NULL,
	[sube_adresi] [nvarchar](300) NULL,
	[sube_telefon_no] [int] NOT NULL,
 CONSTRAINT [PK_subeler] PRIMARY KEY CLUSTERED 
(
	[sube_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[turlar]    Script Date: 22.05.2022 19:27:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[turlar](
	[tur_id] [int] NOT NULL,
	[tur_adi] [nvarchar](100) NOT NULL,
	[tur_sorumlu_id] [int] NOT NULL,
	[tur_ucreti] [int] NULL,
 CONSTRAINT [PK_turlar] PRIMARY KEY CLUSTERED 
(
	[tur_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[araclar] ADD  CONSTRAINT [DF_araclar_arac_plaka]  DEFAULT ((35)) FOR [arac_plaka]
GO
ALTER TABLE [dbo].[rezervasyonlar]  WITH CHECK ADD  CONSTRAINT [FK_rezervasyonlar_musteriler] FOREIGN KEY([rezervasyon_id])
REFERENCES [dbo].[musteriler] ([musteri_id])
GO
ALTER TABLE [dbo].[rezervasyonlar] CHECK CONSTRAINT [FK_rezervasyonlar_musteriler]
GO
ALTER TABLE [dbo].[rezervasyonlar]  WITH CHECK ADD  CONSTRAINT [CK_rezervasyonlar] CHECK  (([rezervasyon_tarihi]>'2022-01-01'))
GO
ALTER TABLE [dbo].[rezervasyonlar] CHECK CONSTRAINT [CK_rezervasyonlar]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "musteriler"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rezervasyonlar"
            Begin Extent = 
               Top = 88
               Left = 343
               Bottom = 218
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 4
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'mus_rezerv'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'mus_rezerv'
GO
USE [master]
GO
ALTER DATABASE [CS_TUR] SET  READ_WRITE 
GO
