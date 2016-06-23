﻿CREATE TABLE [dbo].[AspNetRoles] (
    [Id] [nvarchar](128) NOT NULL,
    [Name] [nvarchar](256) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY ([Id])
)
CREATE UNIQUE INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]([Name])
CREATE TABLE [dbo].[AspNetUserRoles] (
    [UserId] [nvarchar](128) NOT NULL,
    [RoleId] [nvarchar](128) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId])
)
CREATE INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]([UserId])
CREATE INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]([RoleId])
CREATE TABLE [dbo].[AspNetUsers] (
    [Id] [nvarchar](128) NOT NULL,
    [Email] [nvarchar](256),
    [EmailConfirmed] [bit] NOT NULL,
    [PasswordHash] [nvarchar](max),
    [SecurityStamp] [nvarchar](max),
    [PhoneNumber] [nvarchar](max),
    [PhoneNumberConfirmed] [bit] NOT NULL,
    [TwoFactorEnabled] [bit] NOT NULL,
    [LockoutEndDateUtc] [datetime],
    [LockoutEnabled] [bit] NOT NULL,
    [AccessFailedCount] [int] NOT NULL,
    [UserName] [nvarchar](256) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY ([Id])
)
CREATE UNIQUE INDEX [UserNameIndex] ON [dbo].[AspNetUsers]([UserName])
CREATE TABLE [dbo].[AspNetUserClaims] (
    [Id] [int] NOT NULL IDENTITY,
    [UserId] [nvarchar](128) NOT NULL,
    [ClaimType] [nvarchar](max),
    [ClaimValue] [nvarchar](max),
    CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]([UserId])
CREATE TABLE [dbo].[AspNetUserLogins] (
    [LoginProvider] [nvarchar](128) NOT NULL,
    [ProviderKey] [nvarchar](128) NOT NULL,
    [UserId] [nvarchar](128) NOT NULL,
    CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey], [UserId])
)
CREATE INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]([UserId])
CREATE TABLE [dbo].[Products] (
    [UserID] [nvarchar](128) NOT NULL,
    [ProductID] [int] NOT NULL,
    [productName] [nvarchar](max),
    [productDescription] [nvarchar](max),
    [price] [float] NOT NULL,
    [ProductCategoryID] [int] NOT NULL,
    CONSTRAINT [PK_dbo.Products] PRIMARY KEY ([UserID])
)
CREATE INDEX [IX_UserID] ON [dbo].[Products]([UserID])
CREATE INDEX [IX_ProductCategoryID] ON [dbo].[Products]([ProductCategoryID])
CREATE TABLE [dbo].[ProductCategories] (
    [ProductCategoryID] [int] NOT NULL IDENTITY,
    [categoryName] [nvarchar](max),
    [categoryNotes] [nvarchar](max),
    CONSTRAINT [PK_dbo.ProductCategories] PRIMARY KEY ([ProductCategoryID])
)
ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[AspNetUserRoles] ADD CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[AspNetUserClaims] ADD CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[AspNetUserLogins] ADD CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[Products] ADD CONSTRAINT [FK_dbo.Products_dbo.AspNetUsers_UserID] FOREIGN KEY ([UserID]) REFERENCES [dbo].[AspNetUsers] ([Id])
ALTER TABLE [dbo].[Products] ADD CONSTRAINT [FK_dbo.Products_dbo.ProductCategories_ProductCategoryID] FOREIGN KEY ([ProductCategoryID]) REFERENCES [dbo].[ProductCategories] ([ProductCategoryID]) ON DELETE CASCADE
CREATE TABLE [dbo].[__MigrationHistory] (
    [MigrationId] [nvarchar](150) NOT NULL,
    [ContextKey] [nvarchar](300) NOT NULL,
    [Model] [varbinary](max) NOT NULL,
    [ProductVersion] [nvarchar](32) NOT NULL,
    CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
)
INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201605191147262_UserID', N'BikeShopWeb.Migrations.Configuration',  0x1F8B0800000000000400E55DDB6EE4B8117D0F907F10F49404DE6E5F328389D1BD0B4FB79D18195F30EDD9E4CD604BECB630BAAD44796D04F9B23CE493F20B2175E74DA2D4B424275860E116C953C562B1582CB238FFF9D7BF173FBD78AEF10CA3D809FCA579323B360DE85B81EDF8FBA599A0DD0F9FCC9F7EFCED6F1697B6F762FC5CD43B23F5704B3F5E9A4F0885E7F3796C3D410FC433CFB1A2200E76686605DE1CD8C1FCF4F8F84FF3939339C41026C6328CC5D7C4478E07D31FF8E72AF02D18A204B837810DDD38FF8E4B3629AA710B3C1887C0824BF3B3F31D6E9E82F06F703BCB6A9BC685EB00CCC906BA3BD300BE1F2080309FE7DF62B84151E0EF3721FE00DC87D710E27A3BE0C630E7FFBCAAAEDA95E353D29579D5B080B29218055E47C093B35C3673B6792F099BA5ECB0F42EB194D12BE9752AC1A5796DC3F4D3D7C0C50260099EAFDC88545E9A3725898B38BC856856349C6590571186FB3588BECFEA88478672BBA352974E67C7E4BF236395B82889E0D287098A807B64DC275BD7B1FE0A5F1F82EFD05F9E9D6C77679F3E7C04F6D9C73FC2B30FF59EE2BEE27AD407FCE93E0A421861DEE0AEECBF69CCE97673B661D9ACD626930AD6253C2D4CE306BC7C81FE1E3DE10973FAC934AE9C1768175F72E5FAE63B7816E146284AF0CFDBC475C1D68565F9BC9126F97F03D5D30F1FB550BD05CFCE3E1D7A863E9E38119E575FA19B96C64F4E984D2F6ABC1FF36A5751E091DFB47E65A58F9B20892CD299405AE501447B8868EE16F34A7995549A40E957EB0275FAAA4D38E5D55B589574A8CF4C28480C3D1B0A7EDF96AEB2C65D84211EBC54B588449A148E5FAC664CEB23A356A7529D1355D5F17197FE972DE1A5071C57832954A082BD909D1379B0ECE5E7002B1EF03BF37C0FE2185B02FB2F207E6A601DFFA981F50DB492082BE806012F7C736AF74F810F6F136F4BF47E385ADA86E6E1D7E00A5828882E7DD2EA60BC2F81F53D48D0A56FAF0182DF905500929F0F8EA70EA0859D0BCB82717C859519DAAB003BD905E0B58FCE4E3BC3110335B62BB27281E3897D11C6943E16552B7F445C83F34924D5447E4913AB5F82BDE3ABB15A5495B39AD5686535AFD69555FCD34E2C24E4352F7BE4D6B98A594995928D825B59BDA257AAEC123435C1E635E5724D2BB48A35ABA5CD314D154ABF679AC24EDF353DCCD79099AE9A1837D8A0C33F431F46D8EADAF7002118F9D508A898B9317C9B74F808D1375F4A534A3F0337D14DAAD76C486D96FED990C24E7F36A46CE2CFCF8E4D8CAAC27EADA88CE195EA8BB782ED738EE16CE8E940757368E2C3D800E5E952AECF9DF69679ABB1F694A90CD73DE30AEB51148E88AB22DDCF4B0E33981647598F21CF69AD616C454E984589DF9CA463951D5B0758557A4B7A8597E77D10BD7696B8D431E47C54BDFE2CEB26B6F9BD1DDDEF421E4D6C17751E4B93C0B1CD5691B9E15C3D911BDED544557DE863AA8AD663992C816276B55E9D755B9FE36AE53407313D25B100911D966E6A876C55FBCC11C9D496CE2595397211C781E5A44C0A0EDCF2E312BADB97BE6DB49F9D64B266CF5FB0D8F1B4708829C25FF03269B20A7FE7AFA10B11342EACEC407205620BD8BCF47187EC0E8C95068667AC3A87A199FB034713CF4218914680845E633CAF1D1FF153D6F12D27046EAB9498968A3B51D2F792065BB28621F409C15649A810171FBB10064A3ACCA0B4496831AF695CB3224A6265B2316F0B9C55E3CEADAA83E8644BC44EA2977918E64D14B35962032867B3485418901E218EA1A07984545501D870E9D4149489D34A14348F8C0CA2A0B4C44650505A24935750D93642A601AD7B8A4A054AB7851EF8E3D9EC841BFB7602021D6B9D035A34AC85A10154AC45E6CA3AC66D0386D531CE9F6D5101B973CBE958B55D1BC40CB6EE505B278126EBD7222915CD68DD2BF651559964B43134C2D29D9DC1A9AE8CCC81DCD4166EFA2470F80D4FA3B84658B529794C6CD1CE76E5B80DC22D60C4ABE77A4B0AE18B28B08EF9CC0356711EA2605584806F20A2CFA4AB48807087CEADDE3408AB444D8095A2B580E6D73239206E427560AEB85BD1C85DBEBFEA005BDC836884CDBDE216D8DC1A8AC0CAA5450D2237A88E7034B87594C1ACA926DFE5FAADD95A45F9DD5A76CE28858BCA6E954ACACD3DA5E84E0D47A0A7AC4DA53BAE2014D9F51D5E302AC18B2EE18B5AC7F2C16810504BA84122A4A233DAA554CC9876298976D05DF6D0074989D9EF4AA45474E6602949CF78783129EDE33AEDE46A9DAB8C5083ACDA366E6D82EF2F1F3E502E954FF31EA4D32E84974FDDC2B60B4ABA7B5010BC861997DBBBF60927F07B3B78BE074D37DA4BD564B88B638ED2A12ACB16F32C312BFFB0984B32B81637200C1D7F5FCBE8CABF189B2C9D6BF5C3A67B9E939761CC2D4ADAACFB5752424104F69029C5A431A7574E14A33540600BC811D5CAF6B86A42F751E2471424EB1E223F88854751D4267F672D0407A5943BC9FBDB39C615EEA1479CF6F4445130FEE2E606C9B0032E8804B7EF56819B78BE7C0F216F9D1D47D6DB675F7884C59CE19FDB2370D2E27672B4E89506869F149A06A974D1FB0F941C4226EE62835517B86CD32547294EA7EA28B213ABD1064EE614771AAC96855F61AC5A11DE665EE5B9307580FC53478C5A3A0507562B5347A5335EEA9874893A2293D65287648A3A70594F5EA198AC17F4C29348545C439D029FAE5247E74BD59105892B756841710F6C01CF6C993AAA20B7A50E2C2856C7AE125D58233AE1954BBA0BEEBD7465F19BC3D62E09C6DB58443D4B5FED1E7E1DA8F6B923567ED39E03CBBF4F529BA4D182DEDA9485ED0ED3260986DCF25037D869C3D378ED5E8E495D4BA78C7BD3B57C395E379D1D4933CAEDF481FA20091E286881B465A35CD702B90A8EC51A47BBB813CE8C75F1591D8BBA185E47A30A3AE35197BF05B0547917F4F49E370DE8F0597A0AD2AB9F480AA4D8746039B6C6D722537A54BF3C28E83D05E4086F390C326CFACE711D962EE981985D2C16426645032B0B17FF62AB94D4CB381813EF5AE4B1A7F6678DB8605456C5348A5506EF7B5E6304BD19A930DBFCE2AE5C07122FB7A870037C670763945D88374F8F4F4E999791A6F34AD13C8E6D5710BB933D55448FD90049A7FE3388AC2710F1694807BCE453817287CFD7BE0D5F96E63FD256E7699097FC957E3E32AEE36FBEF34B820B1EA2041AFFE433F0F5649D35C7A026FA0E8DBA54AFFFFE98353D32EE223C63CE8D6346967D46987E9DA6133759D303B8E9FD66CDFB9D50D4833042546642F47FFF65EB202D6FBF145CFECE032FBFEFCA9AF07D978310056FB8E8C2D32242D91B2D7DB0A4EFB3D8F8274ADF67E9D659F17B2D7D5893BED5E2F8DDC1D8975AD4CD50D172C4A54610321AC224A5726ECDC03B288F7CECB5897B61E2A089CEBF22D101EE8097227A68C63B7B6441DBEA78CFBFA1A00D7B4CD5EEFC70425FCFF5E0E70BBACB65AD75CAD72255FD97132A40A5C1728822535A606B4F13ECDC00F4F0D764D9DBA9D814869003A04753AB568B2341E367BABFC94A2A4A6E3F485B8409EC1A56306D59DF5349F4AE2E9A8F9BDF3D644A77C3CD1DD5C085F11E32B927906123C818183F5F7B685D931DB57708A84D3F2B7B62CA96E7918C9F7B3DB4B2C94EE227A66C927BF16FA36DAD79D5BD33B4DF8B86C8CFE655F746C3EA45DFACE8E9A4418F97EF3C5E82F3FF4F26F3C456BBB13CF891D73A65277EF4BC643EFF841D5671DE6C3676D55E54B861CCAE0F2C4D7B1B6025C8B6B4D97BB8E22C2019B14A59A404AB2A72A2F2F4239630377138BA5C8D66B2DDFA9A6F391A3B9BD769262B49006DA29D7BA08DB4F33ACDB42569952CED7205E2289625223AE5DDC06EE9D4AF2AC9D40DF4E43983A3E45C0BB3EC44E9F92D065A72F15598E83FE51C6BAA272D2F0DB485031AAF96BFA7946A2D42A1CC82E486F4C433A8758985B158D445E1F79524DD90152D3A7F1C4A0443E53E6B99183A0D68875C67FE4E27760D6BFFA025764F63675F41907FDED28716E5149675AEFD5D50F8A60C474515E618E3062260638FF12242CE0E580817938B24E933BCE9E13CB9CEB485F6B57F97A03041B8CBD0DBBA9456111FB7897E9AD04DF3BCB84BCFED621D5DC06C3AE402CE9DFF39715CBBE4FB4A7044268120CE737ED844C6129143A7FD6B89741BF88A40B9F84A9FFF017AA18BC1E23B7F039E611FDEB0FA7D817B60BD56C7FC3290F681A0C5BE583B601F012FCE31AAF6F827D661DB7BF9F1BFADA0A944D7750000 , N'6.1.3-40302')

