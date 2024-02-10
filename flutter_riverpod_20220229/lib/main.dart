import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final nameProvider = Provider<String>((ref) {
  return 'Nikki';
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Examples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const TimerPage(), //Stream Provider
      //home: const ProductPage(), //Future Provider
      //home: const Counterpage(), //Simple Counter
      home: const Titlepage(), //Utilizando Consumer y ConsumerStatefulWidget.
    );
  }
}

//5.- Streaam Provider
/*Duration duration = const Duration();

final timer = StreamProvider.autoDispose((ref) => Stream.periodic(
  const Duration(seconds: 1), (_) => addTimer(ref),
  )
);

final addSeconds = StateProvider((ref) => 1);

void  addTimer(ref)
{
  final seconds = ref.watch(addSeconds.notifier).state + duration.inSeconds;
  duration = Duration(seconds:  seconds);
}

class TimerPage extends ConsumerWidget
{
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref)
  {
    final streamCount = ref.watch(timer);
    String twoDigits(int n,)=> n.toString().padLeft(2,"0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    String hours = twoDigits(duration.inHours);
    final backGroundColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];


    return Scaffold(
    backgroundColor: backGroundColor,
    appBar: AppBar(
      title: const Text("Stream Provider"),
      ),
    body: Column(
      children: [
        streamCount.when(
          data: (value){
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 40, right: 40, top: 50, bottom: 20),
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 5
                )),
              child: Text(
                  "$hours:$minutes:$seconds",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                  ),
                ),
              );
            },

            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const Center(child: CircularProgressIndicator(color: Colors.white,)),
          ),
        ],
      ),
    );
  }
}*/

//4.- Future Provider
/*class Product
{
  Product({required this.name, required this.price});

  final String name;
  final double price;
}

final _products = [

  Product(name: "Spagetti", price: 10),
  Product(name: "Indomie", price: 6),
  Product(name: "Fried Yam", price: 9),
  Product(name: "Beans", price: 10),
  Product(name: "Red Chicken feet", price: 10),
];

enum ProductSortType
{
  name,
  price,
}

final productSortTypeProvider = StateProvider<ProductSortType>((ref) => ProductSortType.name);

final futureProductsProvider = FutureProvider<List<Product>>((ref) async{
  await Future.delayed(const Duration(seconds: 3));
  final sortType = ref.watch(productSortTypeProvider);

  switch (sortType)
  {
    case ProductSortType.name:
      _products.sort((a, b) => a.name.compareTo(b.name));
      break;
    
    case ProductSortType.price:
      _products.sort((a, b) => a.price.compareTo(b.price));
  }
  return _products;
});

class ProductPage extends ConsumerWidget
{
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref)
  {
    final productsProvider = ref.watch(futureProductsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Future Provider Example"),
        actions: [
          DropdownButton<ProductSortType>(
            dropdownColor: const Color.fromARGB(255, 244, 208, 252),
            value: ref.watch(productSortTypeProvider),
            items: const [
              DropdownMenuItem(
                value: ProductSortType.name,
                child: Icon(Icons.sort_by_alpha),
              ),
              DropdownMenuItem(
                value: ProductSortType.price,
                child: Icon(Icons.sort),
              ),
            ],
            onChanged: (value) => ref.watch(productSortTypeProvider.notifier).state = value!
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 159, 106, 251),
      body: Container(
        child: productsProvider.when(
          data: (products)=> ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index)
            {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Card(
                  color: const Color.fromARGB(255, 205, 139, 250),
                  elevation: 3,
                  child: ListTile(
                    title: Text(products[index].name, style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 15)),
                    subtitle: Text("${products[index].price}", style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 15)),
                  ),
                ),
              );
            }),
          error: (err, stack) => Text("Error: $err", style: const TextStyle(
            color: Colors.white, fontSize: 15)),
          loading: () => const Center(child: CircularProgressIndicator(color:  Color.fromARGB(255, 205, 139, 250),)),
        ),
      )
    );
  }
}*/

//3.- Simple Counter
/*final title = Provider<String>((ref) => "Simple Counter");
final counter = StateProvider((ref) => 0);

class Counterpage extends ConsumerWidget 
{
  const Counterpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) 
  {
    final titleText = ref.watch(title);
    final counterProvider = ref.watch(counter);

    return Scaffold(
        backgroundColor: Colors.purple,
        appBar: AppBar(
          title: const Text("RiverPod Example App"),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.only(top: 30,bottom: 30),
                child: Text(titleText,
                  style: const TextStyle(
                    color: Colors.white,fontSize: 30)),
              ),

               Text(
                counterProvider.toString(),
                style: const TextStyle(color: Colors.white, height: 5, fontSize: 23),
              ),

          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                     label: const Text('Add'),
                      onPressed: ()=> ref.watch(counter.notifier).state++,
                ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.remove),
                    label: const Text('Minus'),
                    onPressed: ()=> ref.watch(counter.notifier).state--,
                  ),
                ),
              ],
            ),

            ElevatedButton.icon(
              icon: const Icon(Icons.replay),
              label: const Text('Refresh'),
              onPressed: ()=> ref.watch(counter.notifier).state = 0,
            ),
          ],
        ),
      )
    );
  }
}*/

//2.- Utilizando ConsumerStatefulWidget.
/*final title = Provider<String>((ref) => "This is our title 2");

class Titlepage extends ConsumerStatefulWidget
{
  const Titlepage({super.key});

  @override
  ConsumerState<Titlepage> createState() => _TitlepageState();
}
class _TitlepageState extends ConsumerState<Titlepage>
{


  @override
  void initState()
  {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context)
  {
    final titleText = ref.watch(title).toString();
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: const Text("RiverPod Example App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Text(titleText,
              style: const TextStyle(
                color: Colors.white, fontSize: 30)),
            ),
          ],
        ),
      )
    );
  }
}*/

//1.- Utilizando Consumer.
final title = Provider<String>((ref) => "This is our title");

class Titlepage extends StatelessWidget
{
  const Titlepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: const Text("RiverPod Example App"),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer(
              builder: ((context, ref, child) {
                final titleText = ref.watch(title).toString();
                return Text(titleText,
                style: const TextStyle(
                  color: Colors.white, height: 10, fontSize: 18));
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}