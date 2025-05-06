<!-- markdownlint-disable first-line-h1 -->
<!-- markdownlint-capture -->
<!-- markdownlint-disable no-inline-html -->
<div align="center">

  <img src="assets/hero.png" alt="MIUI" width="300">

  <!-- markdownlint-disable-next-line heading-start-left -->
  # Redmi 10C debloated MIUI \[WIP\]

  [![sponsor](https://img.shields.io/badge/sponsor-FF6900?logo=githubsponsors&labelColor=FAFAFA&logoColor=FF6900)][sponsor_link]

  > 🩹 Patches for creating a clean MIUI by yourself

</div>
<!-- markdownlint-restore -->

## ✨ Features

- Removed `cust.img` which reduces firmware size by 1.2+ GB and speeds up installation speed by a couple of minutes
- Clean factory firmware that only you can edit and control

## 🛠️ Getting started

> [!WARNING]
> **Disclaimer**
>
> These patches are under development and have not yet been sufficiently tested, all risks associated with modifying system files are your own responsibility.

### Prerequisites

- **OS**: **Linux** (or [**WSL**](https://learn.microsoft.com/windows/wsl/about)) for modifying files and applying patches, the following instructions are written only for Linux, for flashing firmware you can also use Windows
- [git](https://git-scm.com/downloads) (Required)
- [uv](https://github.com/astral-sh/uv#installation) to run Python (Optional)
- 💿 `fog_global_images_V14.0.8.0.TGEMIXM_20240828.0000.00_13.0_global_356db336fa.tgz` ROM (fastboot)

  You can download this firmware from here: <https://xmfirmwareupdater.com/miui/fog/stable/V14.0.8.0.TGEMIXM>

## 📦 Unpacking the Archive

1. Copy the ROM archive to a convenient directory.
2. Verify the MD5 checksum:

   ```bash
   md5sum fog_global_images_V14.0.8.0.TGEMIXM_20240828.0000.00_13.0_global_356db336fa.tgz
   ```

   Make sure the result matches this checksum:

   ```plaintext
   356db336fa0bb08255f74afd21254302
   ```

3. Extract the archive:

   ```bash
   tar -xf fog_global_images_V14.0.8.0.TGEMIXM_20240828.0000.00_13.0_global_356db336fa.tgz
   ```

## 🩹 Applying the Patches

1. Copy the patch folder from this repository to the folder with the extracted ROM
2. Apply all basic patches:

   ```bash
   for patch in patches/*.patch; do git apply "$patch"; done
   ```

   To find out what these patches do, you can read the patch files, they describe in human language what has been changed.

### 🥼 Advanced patches

#### **`images/userdata.img`**

First, you need to unpack this file

To do this, you will need to install the `simg2img` tool:

```bash
sudo apt install android-sdk-libsparse-utils -y
```

Then run the command:

```bash
simg2img images/userdata.img images/userdata.raw.img
```

Then we need to mount the `images/userdata.raw.img` file:

```bash
sudo mount -t f2fs -o loop,rw images/userdata.raw.img images/userdata
```

Now we can apply the patches to the `images/userdata` folder:

```bash
for patch in patches/04-userdata.img/*.patch; do git apply "$patch"; done
```

Now we need to package the image back:

```bash
sudo umount images/userdata
rm images/userdata.img
img2simg images/userdata.raw.img images/userdata.img
rm images/userdata.raw.img
```

Great! `images/userdata.img` is now patched

## ❤️ Support

If you like this project, consider supporting it by starring ⭐ it on GitHub, sharing it with your friends, or [buying me a coffee ☕][sponsor_link]

## 📜 License

[MIT License](./LICENSE) © 2025-present [Yurii Bogdan](https://github.com/okineadev)

[sponsor_link]: https://github.com/okineadev/Redmi-10C-fog-MIUI-V14.0.8.0.TGEMIXM_13.0-patches?sponsor=1
