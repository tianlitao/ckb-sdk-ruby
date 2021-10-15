RSpec.describe CKB::Types::Block do
  let(:block_h) do
    {
      "header": {
        "dao": "0x0100000000000000005827f2ba13b000d77fa3d595aa00000061eb7ada030000",
        "compact_target": "0x7a1200",
        "epoch": "0x1",
        "hash": "0xd629a10a08fb0f43fcb97e948fc2b6eb70ebd28536490fe3864b0e40d08397d1",
        "nonce": "0x0",
        "number": "0x400",
        "parent_hash": "0x30a78d902d7c89ae41feaeb4652c79439e2224a3a32bc0f12059f71d86239d03",
        "proposals_hash": "0x0000000000000000000000000000000000000000000000000000000000000000",
        "timestamp": "0x5cd2b117",
        "transactions_root": "0x8ad0468383d0085e26d9c3b9b648623e4194efc53a03b7cd1a79e92700687f1e",
        "extra_hash": "0x0000000000000000000000000000000000000000000000000000000000000000",
        "version": "0x0",
    },
    "proposals": [], "extension": "0x",
    "transactions": [
        {
            "cell_deps": [],
            "hash": "0x8ad0468383d0085e26d9c3b9b648623e4194efc53a03b7cd1a79e92700687f1e",
            "header_deps": [],
            "inputs": [
                {
                    "previous_output": {
                        "index": "0xffffffff",
                        "tx_hash": "0x0000000000000000000000000000000000000000000000000000000000000000"
                    },
                    "since": "0x400"
                }
            ],
            "outputs": [
                {
                    "capacity": "0x1057d731c2",
                    "lock": {
                        "args": [],
                        "code_hash": "0x28e83a1277d48add8e72fadaa9248559e1b632bab2bd60b27955ebc4c03800a5",
                        "hash_type": "data"
                    },
                    "type": nil
                }
            ],
            "outputs_data": [
                "0x"
            ],
            "version": "0x0",
            "witnesses": [
                {
                    "data": [
                        "0x28e83a1277d48add8e72fadaa9248559e1b632bab2bd60b27955ebc4c03800a500"
                    ]
                }
            ]
        }
      ],
      "uncles": []
    }
  end

  let(:block) { CKB::Types::Block.from_h(block_h) }

  it "from_h" do
    expect(block).to be_a(CKB::Types::Block)
    expect(block.header).to be_a(CKB::Types::BlockHeader)
    expect(block.transactions).to all(be_a(CKB::Types::Transaction))
  end

  it "to_h" do
    expect(
      block.to_h
    ).to eq block_h
  end

  it "serialize" do
    # block 10000 from Lina
    block_h = {:extension => "0x", :uncles=>[], :proposals=>[], :transactions=>[{:version=>"0x0", :cell_deps=>[], :header_deps=>[], :inputs=>[{:previous_output=>{:tx_hash=>"0x0000000000000000000000000000000000000000000000000000000000000000", :index=>"0xffffffff"}, :since=>"0x2710"}], :outputs=>[{:capacity=>"0x19ff6c171e", :lock=>{:code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0xdde7801c073dfb3464c7b1f05b806bb2bbb84e99", :hash_type=>"type"}, :type=>nil}], :outputs_data=>["0x"], :witnesses=>["0x5d0000000c00000055000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce80114000000dde7801c073dfb3464c7b1f05b806bb2bbb84e990400000000000000"], :hash=>"0x09514f1b9a322d311f113e84da3a90f735422ce53f51d348411e9774a488b174"}], :header=>{ :compact_target=>"0x1a717e68", :hash=>"0xaeb0b4eefa4bc35707c9c6cd2c23d454005d5794c64282444eed7d96a4dd0ecd", :number=>"0x2710", :parent_hash=>"0x22f2a939e4ee965080604366801adbca9c445363ae7dea313a0bf98cce3e9391", :nonce=>"0x411d0841020000000000000072600500", :timestamp=>"0x16e8431e26e", :transactions_root=>"0x01bdadd5375de6abc618b4656927792729f183609cde0fd20b84b7ad6d6224d0", :proposals_hash=>"0x0000000000000000000000000000000000000000000000000000000000000000", :extra_hash=>"0x0000000000000000000000000000000000000000000000000000000000000000", :version=>"0x0", :epoch=>"0x708049c000005", :dao=>"0x08f4acdc7434a62eb4b1eae7e287230008b52db8560c010000183ca65e78ff06"}}
    block = CKB::Types::Block.from_h(block_h)
    # encode result by ckb-cli
    expected_serialize_result = "0x3e02000018000000e8000000ec000000360200003a02000000000000687e711a6ee231846e01000010270000000000000500009c0408070022f2a939e4ee965080604366801adbca9c445363ae7dea313a0bf98cce3e939101bdadd5375de6abc618b4656927792729f183609cde0fd20b84b7ad6d6224d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008f4acdc7434a62eb4b1eae7e287230008b52db8560c010000183ca65e78ff0600056072000000000000000241081d41040000004a01000008000000420100000c000000d9000000cd0000001c00000020000000240000002800000058000000c10000000000000000000000000000000100000010270000000000000000000000000000000000000000000000000000000000000000000000000000ffffffff6900000008000000610000001000000018000000610000001e176cff19000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce80114000000dde7801c073dfb3464c7b1f05b806bb2bbb84e990c000000080000000000000069000000080000005d0000005d0000000c00000055000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce80114000000dde7801c073dfb3464c7b1f05b806bb2bbb84e9904000000000000000000000000000000"
    expect(CKB::Serializers::BlockSerializer.new(block).serialize).to eq expected_serialize_result
  end

  it "serialize block with multiple transactions" do
    # block 101 from Lina
    block_h = {:extension => "0x306ef0e7ab2ba12e680b98e6f48623005f5950f3c702000000d5651f78fffe06", :uncles=>[], :proposals=>["0x330c8b030e81bc1805ef", "0x7ebd82392b2f3172965e", "0x2749054fe16f1770e656"], :transactions=>[{:version=>"0x0", :cell_deps=>[], :header_deps=>[], :inputs=>[{:previous_output=>{:tx_hash=>"0x0000000000000000000000000000000000000000000000000000000000000000", :index=>"0xffffffff"}, :since=>"0x65"}], :outputs=>[{:capacity=>"0x1ad91e82ec", :lock=>{:code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0xc2baa1d5b45a3ad6452b9c98ad8e2cc52e5123c7", :hash_type=>"type"}, :type=>nil}], :outputs_data=>["0x"], :witnesses=>["0x5d0000000c00000055000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce80114000000a528f2b9a51118b193178db4cf2f3db92e7df3230400000000000000"], :hash=>"0x9e5c75a7943b51906a8ad51796f7e1830e2b21acace9c8733b28ceca2374af5e"}, {:version=>"0x0", :cell_deps=>[{:out_point=>{:tx_hash=>"0x71a7ba8fc96349fea0ed3a5c47992e3b4084b031a42264a018e0072e8172e46c", :index=>"0x0"}, :dep_type=>"dep_group"}], :header_deps=>[], :inputs=>[{:previous_output=>{:tx_hash=>"0xa70a2f08bf1f03d9bc0397e2dec1c648796662d667d89491753edd0a5337db1b", :index=>"0x8"}, :since=>"0x0"}, {:previous_output=>{:tx_hash=>"0xa70a2f08bf1f03d9bc0397e2dec1c648796662d667d89491753edd0a5337db1b", :index=>"0x7"}, :since=>"0x0"}, {:previous_output=>{:tx_hash=>"0xa70a2f08bf1f03d9bc0397e2dec1c648796662d667d89491753edd0a5337db1b", :index=>"0x2"}, :since=>"0x0"}, {:previous_output=>{:tx_hash=>"0xa70a2f08bf1f03d9bc0397e2dec1c648796662d667d89491753edd0a5337db1b", :index=>"0x3"}, :since=>"0x0"}], :outputs=>[{:capacity=>"0x4a817c800", :lock=>{:code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0x59061df659b35dadad768ee29f950d2416a24eb9", :hash_type=>"type"}, :type=>nil}, {:capacity=>"0x2cb40a510", :lock=>{:code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0xa7327b7d9ddd68843503d710879bddd7ab883f50", :hash_type=>"type"}, :type=>nil}], :outputs_data=>["0x", "0x"], :witnesses=>["0x550000001000000055000000550000004100000035c89a2ca07644542f719a372a46b6c8126ea9b96048afbe9716b32f8a04f12f03292fcd44616ec2e10c933da6228309720ae3406a8d8f7dc68f5a824d4d7c9401", "0x", "0x", "0x"], :hash=>"0xd5bbd540d5f5512cd4808ab061fde980eaf11e3430172a3ca5d1e38678a63c28"}, {:version=>"0x0", :cell_deps=>[{:out_point=>{:tx_hash=>"0x71a7ba8fc96349fea0ed3a5c47992e3b4084b031a42264a018e0072e8172e46c", :index=>"0x0"}, :dep_type=>"dep_group"}], :header_deps=>[], :inputs=>[{:previous_output=>{:tx_hash=>"0xbfeccff6239e2d48f7d46f20754c4b0cbac1f07b6dcade70bd3b0c2c5798a5b8", :index=>"0x1"}, :since=>"0x0"}], :outputs=>[{:capacity=>"0x174876e800", :lock=>{:code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0xac5870b50761e4bd33a582467cf0d371d22f4004", :hash_type=>"type"}, :type=>nil}, {:capacity=>"0x21c2ac5d44", :lock=>{:code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0xbe61c6d2ce893a39e94cda2ac9f648e7c4c3cacf", :hash_type=>"type"}, :type=>nil}], :outputs_data=>["0x", "0x"], :witnesses=>["0x550000001000000055000000550000004100000055d1c6281e6a9ef1ef40e92e275fba403797b485b1990da458f29d42136c5d040f9d76e91a395c92d5ca298f7b5a816e791c7048d6f9f63d78d2a24b36d86fe401"], :hash=>"0x377adba95da7c942044e0f1008a1ffed0dba9b3bdc34a4a11f92b5e683db20d5"}, {:version=>"0x0", :cell_deps=>[{:out_point=>{:tx_hash=>"0x71a7ba8fc96349fea0ed3a5c47992e3b4084b031a42264a018e0072e8172e46c", :index=>"0x0"}, :dep_type=>"dep_group"}], :header_deps=>[], :inputs=>[{:previous_output=>{:tx_hash=>"0xfc39f59c824f9e21ad2a3c052e25844d7c27cd45fc9d84fca98c71733a66fc74", :index=>"0x0"}, :since=>"0x0"}, {:previous_output=>{:tx_hash=>"0x9588e0938c5ba4c3346133443e703d435fdc1dadd90f65f5e9ef3d274e73b7ca", :index=>"0x0"}, :since=>"0x0"}, {:previous_output=>{:tx_hash=>"0x6baa4d9922c5465e3f7e6075325abdf965726fa396d507793815951f1ac89fe4", :index=>"0x0"}, :since=>"0x0"}, {:previous_output=>{:tx_hash=>"0x2325fe2701c05ed5a5f4527b237418596ffe70ab68a0318dc845725cb2c581cc", :index=>"0x0"}, :since=>"0x0"}, {:previous_output=>{:tx_hash=>"0xfbaec0748af562523fe057b2404ff2e02060e90cc40d0ec8e69a3ae8983fa3fe", :index=>"0x0"}, :since=>"0x0"}, {:previous_output=>{:tx_hash=>"0x8a45812d3d31a825d33ed8ae3e999ce4ec9cfded18a76d8dc0230330639695bc", :index=>"0x0"}, :since=>"0x0"}, {:previous_output=>{:tx_hash=>"0x513be2ad17b55c24253249e9329993a774a89b225b15f43d748d0617656a5899", :index=>"0x0"}, :since=>"0x0"}], :outputs=>[{:capacity=>"0x574fbde6000", :lock=>{:code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0x8ad2baaddc75e093db19181b60812f7f4442d03e", :hash_type=>"type"}, :type=>nil}, {:capacity=>"0xde12e8f260", :lock=>{:code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0xdd2a6969cbb346047106c9c633b1f5521a084724", :hash_type=>"type"}, :type=>nil}], :outputs_data=>["0x", "0x"], :witnesses=>["0x5500000010000000550000005500000041000000a92ca3605697c7ec3864a3a3d3ceff19c93d59d27d785007035e1f102ac40f2a230991045c3e5b10d54c90dc4a937dd763383d6c25e01253b470b02edbb7f45400", "0x", "0x", "0x", "0x", "0x", "0x"], :hash=>"0x785319a921bf0f44d39e359f90c4033841b878148c9bff2f9a08d60994af3cfc"}, {:version=>"0x0", :cell_deps=>[{:out_point=>{:tx_hash=>"0x71a7ba8fc96349fea0ed3a5c47992e3b4084b031a42264a018e0072e8172e46c", :index=>"0x0"}, :dep_type=>"dep_group"}], :header_deps=>[], :inputs=>[{:previous_output=>{:tx_hash=>"0xb5c33e134f0a543e967f8eea27806b62183ae32e4b712a97eef6d31eae4d6ba0", :index=>"0x5"}, :since=>"0x0"}], :outputs=>[{:capacity=>"0x2540be400", :lock=>{:code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0x22de4777057996c898c144e026df97ca895444f0", :hash_type=>"type"}, :type=>nil}, {:capacity=>"0x4f949f48aab0ac", :lock=>{:code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0x1b218616e37acecbfbdeaeed5025479ada87fad2", :hash_type=>"type"}, :type=>nil}], :outputs_data=>["0x", "0x"], :witnesses=>["0x5500000010000000550000005500000041000000396170fde0e66c64855910a7e19d1f2f0b051d6b0e310874fec9c94a20a4fc7f7e240258460b40dcca2aa6cf86394ae4326f9517d8e3f47b20c6c608c551614400"], :hash=>"0x81f6467121a45c45d2c37cfdbd8db4ff60c3849cecda638f4985e927e7987bda"}, {:version=>"0x0", :cell_deps=>[{:out_point=>{:tx_hash=>"0x71a7ba8fc96349fea0ed3a5c47992e3b4084b031a42264a018e0072e8172e46c", :index=>"0x0"}, :dep_type=>"dep_group"}], :header_deps=>[], :inputs=>[{:previous_output=>{:tx_hash=>"0xe2fb199810d49a4d8beec56718ba2593b665db9d52299a0f9e6e75416d73ff5c", :index=>"0x15a"}, :since=>"0x0"}], :outputs=>[{:capacity=>"0xe8d4a51000", :lock=>{:code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0x6200c348c1639bcc320d5cf024a104b27c41cca9", :hash_type=>"type"}, :type=>nil}, {:capacity=>"0x13e442c618ee30", :lock=>{:code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0xafb67b1452547442d9d73e79efcfa3841d8f51fe", :hash_type=>"type"}, :type=>nil}], :outputs_data=>["0x", "0x"], :witnesses=>["0x5500000010000000550000005500000041000000e8501fa5abe7b8c6dc470dfc16106f2e571710440549db13401f2abad0ab46594e8498eab6f63402a8ffa7083105f5cca35839c34ec1a1233c595a08e4e1115400"], :hash=>"0x5010efc26b9c03a98ca2126d44e4152729097cb56117b99d8a7117635b4ae378"}], :header=>{ :compact_target=>"0x1a08a97e", :hash=>"0x45d65abf7eae713aef9c20cefdcf28c2bcb44b885e24c6e8ae7c2fab16803a25", :number=>"0x65", :parent_hash=>"0xdf49b9fe0e635144f181c74a4d36da231acc4810c813c7f29dd0702bf5cdfb1d", :nonce=>"0x939cd20000000000000018963a700000", :timestamp=>"0x16e7173a967", :transactions_root=>"0x582bace17a981a1ef29707f94885104aba6bbe01226bfd8e0b397f579de6877b", :proposals_hash=>"0x11c0a4a5a8c6943c4b2d79fc09949fb2a60b805ba66c7c16b28536a85a8e6601", :extra_hash=>"0x0000000000000000000000000000000000000000000000000000000000000000", :version=>"0x0", :epoch=>"0x6cf0065000000", :dao=>"0x306ef0e7ab2ba12e680b98e6f48623005f5950f3c702000000d5651f78fffe06"}}
    block = CKB::Types::Block.from_h(block_h)
    # encode result by ckb-cli
    expected_serialize_result = "0x600d000018000000e8000000ec0000001a0d00003c0d0000000000007ea9081a67a973716e01000065000000000000000000006500cf0600df49b9fe0e635144f181c74a4d36da231acc4810c813c7f29dd0702bf5cdfb1d582bace17a981a1ef29707f94885104aba6bbe01226bfd8e0b397f579de6877b11c0a4a5a8c6943c4b2d79fc09949fb2a60b805ba66c7c16b28536a85a8e66010000000000000000000000000000000000000000000000000000000000000000306ef0e7ab2ba12e680b98e6f48623005f5950f3c702000000d5651f78fffe060000703a961800000000000000d29c93040000002e0c00001c0000005e010000c60300009205000096080000620a0000420100000c000000d9000000cd0000001c00000020000000240000002800000058000000c10000000000000000000000000000000100000065000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffff690000000800000061000000100000001800000061000000ec821ed91a000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce80114000000c2baa1d5b45a3ad6452b9c98ad8e2cc52e5123c70c000000080000000000000069000000080000005d0000005d0000000c00000055000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce80114000000a528f2b9a51118b193178db4cf2f3db92e7df3230400000000000000680200000c000000ef010000e30100001c00000020000000490000004d00000001010000cf010000000000000100000071a7ba8fc96349fea0ed3a5c47992e3b4084b031a42264a018e0072e8172e46c000000000100000000040000000000000000000000a70a2f08bf1f03d9bc0397e2dec1c648796662d667d89491753edd0a5337db1b080000000000000000000000a70a2f08bf1f03d9bc0397e2dec1c648796662d667d89491753edd0a5337db1b070000000000000000000000a70a2f08bf1f03d9bc0397e2dec1c648796662d667d89491753edd0a5337db1b020000000000000000000000a70a2f08bf1f03d9bc0397e2dec1c648796662d667d89491753edd0a5337db1b03000000ce0000000c0000006d0000006100000010000000180000006100000000c817a804000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8011400000059061df659b35dadad768ee29f950d2416a24eb96100000010000000180000006100000010a540cb02000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce80114000000a7327b7d9ddd68843503d710879bddd7ab883f50140000000c00000010000000000000000000000079000000140000006d000000710000007500000055000000550000001000000055000000550000004100000035c89a2ca07644542f719a372a46b6c8126ea9b96048afbe9716b32f8a04f12f03292fcd44616ec2e10c933da6228309720ae3406a8d8f7dc68f5a824d4d7c9401000000000000000000000000cc0100000c0000006b0100005f0100001c00000020000000490000004d0000007d0000004b010000000000000100000071a7ba8fc96349fea0ed3a5c47992e3b4084b031a42264a018e0072e8172e46c000000000100000000010000000000000000000000bfeccff6239e2d48f7d46f20754c4b0cbac1f07b6dcade70bd3b0c2c5798a5b801000000ce0000000c0000006d0000006100000010000000180000006100000000e8764817000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce80114000000ac5870b50761e4bd33a582467cf0d371d22f400461000000100000001800000061000000445dacc221000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce80114000000be61c6d2ce893a39e94cda2ac9f648e7c4c3cacf140000000c000000100000000000000000000000610000000800000055000000550000001000000055000000550000004100000055d1c6281e6a9ef1ef40e92e275fba403797b485b1990da458f29d42136c5d040f9d76e91a395c92d5ca298f7b5a816e791c7048d6f9f63d78d2a24b36d86fe401040300000c00000073020000670200001c00000020000000490000004d0000008501000053020000000000000100000071a7ba8fc96349fea0ed3a5c47992e3b4084b031a42264a018e0072e8172e46c000000000100000000070000000000000000000000fc39f59c824f9e21ad2a3c052e25844d7c27cd45fc9d84fca98c71733a66fc740000000000000000000000009588e0938c5ba4c3346133443e703d435fdc1dadd90f65f5e9ef3d274e73b7ca0000000000000000000000006baa4d9922c5465e3f7e6075325abdf965726fa396d507793815951f1ac89fe40000000000000000000000002325fe2701c05ed5a5f4527b237418596ffe70ab68a0318dc845725cb2c581cc000000000000000000000000fbaec0748af562523fe057b2404ff2e02060e90cc40d0ec8e69a3ae8983fa3fe0000000000000000000000008a45812d3d31a825d33ed8ae3e999ce4ec9cfded18a76d8dc0230330639695bc000000000000000000000000513be2ad17b55c24253249e9329993a774a89b225b15f43d748d0617656a589900000000ce0000000c0000006d000000610000001000000018000000610000000060defb74050000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce801140000008ad2baaddc75e093db19181b60812f7f4442d03e6100000010000000180000006100000060f2e812de000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce80114000000dd2a6969cbb346047106c9c633b1f5521a084724140000000c0000001000000000000000000000009100000020000000790000007d0000008100000085000000890000008d000000550000005500000010000000550000005500000041000000a92ca3605697c7ec3864a3a3d3ceff19c93d59d27d785007035e1f102ac40f2a230991045c3e5b10d54c90dc4a937dd763383d6c25e01253b470b02edbb7f45400000000000000000000000000000000000000000000000000cc0100000c0000006b0100005f0100001c00000020000000490000004d0000007d0000004b010000000000000100000071a7ba8fc96349fea0ed3a5c47992e3b4084b031a42264a018e0072e8172e46c000000000100000000010000000000000000000000b5c33e134f0a543e967f8eea27806b62183ae32e4b712a97eef6d31eae4d6ba005000000ce0000000c0000006d0000006100000010000000180000006100000000e40b5402000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8011400000022de4777057996c898c144e026df97ca895444f061000000100000001800000061000000acb0aa489f944f00490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce801140000001b218616e37acecbfbdeaeed5025479ada87fad2140000000c0000001000000000000000000000006100000008000000550000005500000010000000550000005500000041000000396170fde0e66c64855910a7e19d1f2f0b051d6b0e310874fec9c94a20a4fc7f7e240258460b40dcca2aa6cf86394ae4326f9517d8e3f47b20c6c608c551614400cc0100000c0000006b0100005f0100001c00000020000000490000004d0000007d0000004b010000000000000100000071a7ba8fc96349fea0ed3a5c47992e3b4084b031a42264a018e0072e8172e46c000000000100000000010000000000000000000000e2fb199810d49a4d8beec56718ba2593b665db9d52299a0f9e6e75416d73ff5c5a010000ce0000000c0000006d000000610000001000000018000000610000000010a5d4e8000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce801140000006200c348c1639bcc320d5cf024a104b27c41cca96100000010000000180000006100000030ee18c642e41300490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce80114000000afb67b1452547442d9d73e79efcfa3841d8f51fe140000000c0000001000000000000000000000006100000008000000550000005500000010000000550000005500000041000000e8501fa5abe7b8c6dc470dfc16106f2e571710440549db13401f2abad0ab46594e8498eab6f63402a8ffa7083105f5cca35839c34ec1a1233c595a08e4e111540003000000330c8b030e81bc1805ef7ebd82392b2f3172965e2749054fe16f1770e65620000000306ef0e7ab2ba12e680b98e6f48623005f5950f3c702000000d5651f78fffe06"
    expect(CKB::Serializers::BlockSerializer.new(block).serialize).to eq expected_serialize_result
  end

  it "serialize block with uncles" do
    # block 904 from Lina
    block_h = {:extension => "0x", :uncles=>[{:proposals=>["0x47a1a0dc8308902a4b4f", "0x88caab22953f4d3ff218", "0x52ca72462ba65e5af75e", "0x96a191bfeaf77fa351f9"], :header=>{ :compact_target=>"0x1a08a97e", :hash=>"0x300f8cc8d0e0c791e944484f2fd565bc01d775a6104180545087d7ec925c3e30", :number=>"0x387", :parent_hash=>"0xfbaa7c7ae19f2f99c971ae93d21a6f514d83e1528475c2ea1bd2e633574623f2", :nonce=>"0x10d813d90000019d000000000e150200", :timestamp=>"0x16e77154097", :transactions_root=>"0x23d5696b2219ebca71b9371b29b646c1ea8fcdc3160c86c8602958a51f4ba53c", :proposals_hash=>"0x2ee20468abe9e7766b5d4a88f2b8d3ebb65024bef3e463192776b9b35ac95315", :extra_hash=>"0x0000000000000000000000000000000000000000000000000000000000000000", :version=>"0x0", :epoch=>"0x6cf0387000000", :dao=>"0x408083509c95a12e28adc377088723001c2bf91a9c18000000a00cf2b338ff06"}}], :proposals=>["0x1b61eeaeaed2ed6da110", "0x8b5f2f5033e4f78eb8d8", "0x63c4007a78cdbcfea1e6", "0x18b874925241a7f55fb0"], :transactions=>[{ :version=>"0x0", :cell_deps=>[], :header_deps=>[], :inputs=>[{ :previous_output=>{ :tx_hash=>"0x0000000000000000000000000000000000000000000000000000000000000000", :index=>"0xffffffff"}, :since=>"0x388"}], :outputs=>[{ :capacity=>"0x1ad925c507", :lock=>{ :code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0x0a486fb8f6fe60f76f001d6372da41be91172259", :hash_type=>"type"}, :type=>nil}], :outputs_data=>["0x"], :witnesses=>["0x5a0000000c00000055000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce801140000000a486fb8f6fe60f76f001d6372da41be911722590100000000"], :hash=>"0x4e52431821736d3a37d8e5aeed67615c0c722a6f064b788acb2bd9322f6ed47a"}, { :version=>"0x0", :cell_deps=>[{ :out_point=>{ :tx_hash=>"0x71a7ba8fc96349fea0ed3a5c47992e3b4084b031a42264a018e0072e8172e46c", :index=>"0x0"}, :dep_type=>"dep_group"}], :header_deps=>[], :inputs=>[{ :previous_output=>{ :tx_hash=>"0xb4aa8c05207ec3e67e6408473cd93bdb89780864446bc7d6b6812b539c33d096", :index=>"0x1"}, :since=>"0x0"}], :outputs=>[{ :capacity=>"0x453b118f700", :lock=>{ :code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0x04e058890224cbb41e9fed2b10ce3ad20f014cda", :hash_type=>"type"}, :type=>nil}, { :capacity=>"0x4bc772aa88c", :lock=>{ :code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0x6d9e5654ec5c0435dedd7fc869b66ba47eb60208", :hash_type=>"type"}, :type=>nil}], :outputs_data=>["0x", "0x"], :witnesses=>["0x5500000010000000550000005500000041000000f0ac95a3667c757b7e08783f7f0f78db47dfcd76511e42bf4f01435507fda0b8210a521fa12012aa70921f6e6e00dd2a7c1296512632f1dfb26957d9b409284701"], :hash=>"0x47a1a0dc8308902a4b4f2a921c0199dfc2cfa23a163f26398d8dc1f3529b2a51"}, { :version=>"0x0", :cell_deps=>[{ :out_point=>{ :tx_hash=>"0x71a7ba8fc96349fea0ed3a5c47992e3b4084b031a42264a018e0072e8172e46c", :index=>"0x0"}, :dep_type=>"dep_group"}], :header_deps=>[], :inputs=>[{ :previous_output=>{ :tx_hash=>"0x3ce938e5b12f707a0dd3122604f844509192bc6cb21377389ec8509683380839", :index=>"0x1"}, :since=>"0x0"}], :outputs=>[{ :capacity=>"0xba43b7400", :lock=>{ :code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0x3ff943b23be06ac76ac9de7c02ec0ede8286d47c", :hash_type=>"type"}, :type=>nil}, { :capacity=>"0x6fc2336d0", :lock=>{ :code_hash=>"0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8", :args=>"0x56b1a3bed66c86b40151f2ba1bfe296032dd307b", :hash_type=>"type"}, :type=>nil}], :outputs_data=>["0x", "0x"], :witnesses=>["0x55000000100000005500000055000000410000000881853578e3ca9a3cb7a0faf5ba6b15f2a479c16f40e73f2e9b4552f900913c25da1d4ba34d16442e2c80d3ce62f72c7e0778a05f058e081c094ef4a865900700"], :hash=>"0x96a191bfeaf77fa351f9c5e59cc71893fd7d338317b0d5a766a9985216d84720"}], :header=>{ :compact_target=>"0x1a08a97e", :hash=>"0x04ca5b716e7463a6cffe5f978f1b68de727f623af77f8361241cb40e45b91de2", :number=>"0x388", :parent_hash=>"0xf85598a6ea16e07c7b8dd612eccf7620f44b643a9faceb9f6efe7b6320282794", :nonce=>"0x5d9a05000000000000004a0b000001ba", :timestamp=>"0x16e77208628", :transactions_root=>"0xb7152b63347f20ac999a51a5a80e0a80c8a703dad686c2a65f084c9acd9f596c", :proposals_hash=>"0xad225773c594929c7fd60b82b0cb300a42fe7c6235f40ca70ce6c35f69d4c061", :extra_hash=>"0x2d54b7e61b1a37d813ff4c1a13061973f6f5aed878b84765570228f7b17f7fe2", :version=>"0x0", :epoch=>"0x6cf0388000000", :dao=>"0xc8f46621be95a12eb297027e08872300aee0b612a31800000077d034b838ff06"}}
    block = CKB::Types::Block.from_h(block_h)
    # encode result by ckb-cli
    expected_serialize_result = "0x0f07000018000000e8000000f8010000df0600000b070000000000007ea9081a288620776e01000088030000000000000000008803cf0600f85598a6ea16e07c7b8dd612eccf7620f44b643a9faceb9f6efe7b6320282794b7152b63347f20ac999a51a5a80e0a80c8a703dad686c2a65f084c9acd9f596cad225773c594929c7fd60b82b0cb300a42fe7c6235f40ca70ce6c35f69d4c0612d54b7e61b1a37d813ff4c1a13061973f6f5aed878b84765570228f7b17f7fe2c8f46621be95a12eb297027e08872300aee0b612a31800000077d034b838ff06ba0100000b4a00000000000000059a5d1001000008000000080100000c000000dc000000000000007ea9081a974015776e01000087030000000000000000008703cf0600fbaa7c7ae19f2f99c971ae93d21a6f514d83e1528475c2ea1bd2e633574623f223d5696b2219ebca71b9371b29b646c1ea8fcdc3160c86c8602958a51f4ba53c2ee20468abe9e7766b5d4a88f2b8d3ebb65024bef3e463192776b9b35ac953150000000000000000000000000000000000000000000000000000000000000000408083509c95a12e28adc377088723001c2bf91a9c18000000a00cf2b338ff060002150e000000009d010000d913d8100400000047a1a0dc8308902a4b4f88caab22953f4d3ff21852ca72462ba65e5af75e96a191bfeaf77fa351f9e7040000100000004f0100001b0300003f0100000c000000d9000000cd0000001c00000020000000240000002800000058000000c10000000000000000000000000000000100000088030000000000000000000000000000000000000000000000000000000000000000000000000000ffffffff69000000080000006100000010000000180000006100000007c525d91a000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce801140000000a486fb8f6fe60f76f001d6372da41be911722590c000000080000000000000066000000080000005a0000005a0000000c00000055000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce801140000000a486fb8f6fe60f76f001d6372da41be911722590100000000cc0100000c0000006b0100005f0100001c00000020000000490000004d0000007d0000004b010000000000000100000071a7ba8fc96349fea0ed3a5c47992e3b4084b031a42264a018e0072e8172e46c000000000100000000010000000000000000000000b4aa8c05207ec3e67e6408473cd93bdb89780864446bc7d6b6812b539c33d09601000000ce0000000c0000006d0000006100000010000000180000006100000000f718b153040000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8011400000004e058890224cbb41e9fed2b10ce3ad20f014cda610000001000000018000000610000008ca82a77bc040000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce801140000006d9e5654ec5c0435dedd7fc869b66ba47eb60208140000000c0000001000000000000000000000006100000008000000550000005500000010000000550000005500000041000000f0ac95a3667c757b7e08783f7f0f78db47dfcd76511e42bf4f01435507fda0b8210a521fa12012aa70921f6e6e00dd2a7c1296512632f1dfb26957d9b409284701cc0100000c0000006b0100005f0100001c00000020000000490000004d0000007d0000004b010000000000000100000071a7ba8fc96349fea0ed3a5c47992e3b4084b031a42264a018e0072e8172e46c0000000001000000000100000000000000000000003ce938e5b12f707a0dd3122604f844509192bc6cb21377389ec850968338083901000000ce0000000c0000006d0000006100000010000000180000006100000000743ba40b000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce801140000003ff943b23be06ac76ac9de7c02ec0ede8286d47c61000000100000001800000061000000d03623fc06000000490000001000000030000000310000009bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8011400000056b1a3bed66c86b40151f2ba1bfe296032dd307b140000000c00000010000000000000000000000061000000080000005500000055000000100000005500000055000000410000000881853578e3ca9a3cb7a0faf5ba6b15f2a479c16f40e73f2e9b4552f900913c25da1d4ba34d16442e2c80d3ce62f72c7e0778a05f058e081c094ef4a865900700040000001b61eeaeaed2ed6da1108b5f2f5033e4f78eb8d863c4007a78cdbcfea1e618b874925241a7f55fb000000000"
    expect(CKB::Serializers::BlockSerializer.new(block).serialize).to eq expected_serialize_result
  end
end
