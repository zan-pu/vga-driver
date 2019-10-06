<img src="https://avatars2.githubusercontent.com/u/54571645?s=200&v=4" align="right" width="120px">

# 📺 VGA Driver

**VGA Driver** for ZanPU. 
This project is the team project of BIT's 2019 summer CPU-building lecture. 

## Usage

- Open Vivado
- Run sythesis, implementation
- Program board
- Hook board to VGA display
- Profit

## Source Code

All source codes are available at:

- [Design Sources](vga-driver.srcs/sources_1)
- [Simulation Sources](vga-driver.srcs/sim_1)
- [Constraints](vga-driver.srcs/constrs_1)
- [Independent IP Package](vga-driver.srcs/xgui)

## Versions

[Branch master](https://github.com/zan-pu/vga-driver/tree/master) is available as a module for ZanPU. It takes input similar to the data memory module in ZanPU, where the instruction `SW` and `LW` is used to manipulate data.

[Branch standalone](https://github.com/zan-pu/vga-driver/tree/standalone) is built as a standalone version of the VGA driver. It's able to operate by itself and outputs a still image.

---

📺 **VGA Driver** ©2019 ZanPU. Released under the [MIT License](./LICENSE).

Authored and maintained by Team ZanPU.

Created with love ♥ from BIT, Beijing.

[@BIT](https://www.bit.edu.cn) · [@GitHub](https://github.com/zan-pu) · [Documentation](https://zanpu.spencerwoo.com)
