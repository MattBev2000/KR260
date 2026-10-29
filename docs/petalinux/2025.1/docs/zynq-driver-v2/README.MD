# Generatore driver Zynq con BRAM e GPIO Xilinx

I tre file di questa cartella sono versioni nuove: gli originali non vengono
modificati.

## Uso

Tenere i tre file nella stessa directory ed eseguire:

```bash
python3 get_device_tree_info.py <nome_driver> <device_tree.dts> [fifo_sincrona]
```

Il comando genera `<nome_driver>.c` e `<nome_driver>.h`.

Il generatore riconosce:s

- `axi_cfg_register`
- `axi_sts_register`
- `axi_fifo_mm_s`
- Xilinx AXI BRAM Controller
- Xilinx AXI GPIO, compresi i nodi chiamati semplicemente `gpio@...`

Le stringhe `compatible` trovate nel DTS vengono riportate automaticamente
nella tabella di match del driver.

## Accesso a BRAM e GPIO

Per ogni BRAM o GPIO vengono creati due IOCTL:

```c
<DRIVER>_READ_<LABEL>
<DRIVER>_WRITE_<LABEL>
```

Entrambi usano questa struttura, generata nell'header:

```c
struct <nome_driver>_mmio_access {
    __u32 offset;
    __u32 value;
};
```

Esempio di lettura:

```c
struct mydriver_mmio_access access = {
    .offset = 0,
};

if (ioctl(fd, MYDRIVER_READ_AXI_BRAM_CTRL_0, &access) == -1)
    perror("ioctl");
else
    printf("0x%08x\n", access.value);
```

Esempio di scrittura:

```c
struct mydriver_mmio_access access = {
    .offset = 0,
    .value = 0x12345678,
};

if (ioctl(fd, MYDRIVER_WRITE_AXI_BRAM_CTRL_0, &access) == -1)
    perror("ioctl");
```

L'offset deve essere allineato a 4 byte e deve rientrare nella dimensione
`reg` della periferica. Il driver verifica entrambe le condizioni.

Per ogni AXI GPIO l'header contiene anche le costanti degli offset standard:
`DATA`, `TRI`, `DATA2`, `TRI2`, `GIER`, `IP_ISR` e `IP_IER`. Gli offset del
secondo canale possono essere usati solo se il core GPIO è configurato come
dual-channel.
