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
- [uv] to run Python
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
mkdir images/userdata
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
rm -rf images/userdata
```

Great! `images/userdata.img` is now patched

---

#### **`images/super.img`**

> [!WARNING]
> This section is a WIP and is not yet complete and may change.

We need to unpack all the partitions from `super.img` into the `images/super` folder, for this we need [`uv`][uv] to run the Python script `lpunpack.py` which you can grab from this repository, then run this command:

```bash
mkdir images/super
uv run lpunpack.py images/super.img images/super
```

##### **`mi_ext_a.img`**

\[WIP\]

##### **`product_a.img`**

In order for us to be able to unpack this file, we need to allocate a little more space in the image, the file itself is **4.5+ GB**, and we need to increase its size to **5 GB** (**Required**):

```bash
fallocate images/super/product_a.img -l 5G
resize2fs images/super/product_a.img 5G
```

We need to disable the `shared_blocks` option, otherwise we won't be able to mount the image (see [https://blog.senyuuri.info/posts/2022-04-27-patching-android-super-images](https://blog.senyuuri.info/posts/2022-04-27-patching-android-super-images/#:~:text=It%20turned%20out%20that%20system%20imgage%20in%20Android%2010%2B%20is%20formated%20with%20EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS%2C%20found%20by%20%40topjohnwu) and <https://x.com/topjohnwu/status/1170404631865778177>)

```bash
e2fsck -E unshare_blocks images/super/product_a.img
```

Now we can mount the image:

```bash
mkdir images/super/product_a
sudo mount -t ext4 -o loop images/super/product_a.img images/super/product_a
```

> [!IMPORTANT]
> When editing any files, you **must** use `sudo` and it is preferable to do all operations only in the terminal, otherwise you have a chance to break the image.

Next we can apply the patches, note that we use `sudo git apply` here.

```bash
for patch in patches/05-super.img/02-product_a.img/*.patch; do sudo git apply "$patch"; done
```

> [!TIP]
> You can also edit `etc/build.prop` here 🙂

After applying the patches, we need to unmount the image and shrink it to its actual size:

```bash
sudo umount images/super/product_a
e2fsck -yf images/super/product_a.img
resize2fs -M images/super/product_a.img
e2fsck -yf images/super/product_a.img
rm -rf images/super/product_a
```

## 📰 Useful articles that have made a significant contribution to this project

- <https://blog.senyuuri.info/posts/2022-04-27-patching-android-super-images>
- <https://xdaforums.com/t/editing-system-img-inside-super-img-and-flashing-our-modifications.4196625>

## ❤️ Support

If you like this project, consider supporting it by starring ⭐ it on GitHub, sharing it with your friends, or [buying me a coffee ☕][sponsor_link]

## 📜 License

[MIT License](./LICENSE) © 2025-present [Yurii Bogdan](https://github.com/okineadev)

[uv]: https://github.com/astral-sh/uv#installation
[sponsor_link]: https://github.com/okineadev/Redmi-10C-fog-MIUI-V14.0.8.0.TGEMIXM_13.0-patches?sponsor=1
