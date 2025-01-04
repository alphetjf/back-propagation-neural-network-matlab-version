# Back-propagation-neural-network-matlab-version

---

A back propagation (BP) neutral network in Matlab

---

## Tutorial
This program uses Matlab to create and train a BP neural network.

Run this program by running the **example.m** file, which contains  the following steps:

1. Creation of training data;
2. Create and train a BP network;
3. Create new data tests;
4. Draw the results;
5. Save model parameters;
6. Load model parameters.

You can change the training set, number of neurons in the hidden layer, and number of training epochs in **example.m**, batch_size。

The **BPNetwork.m** file contains the network structure, forward and backward propagation, and the learning rate can be modified in this file.

---

## Engineering case

In the file **example 2.m**, an engineering case for testing the aging suitability evaluation system of rural living environment has been added. from these 18 indicators:

    'Living room';
    'Bedroom space';
    'Kitchen and dining space';
    'Bathroom space';
    'Residential transportation space';
    'Residential structural safety';
    'Safety of household devices';
    'Road network layout';
    'Accessibility for travel';
    'Living infrastructure';
    'Medical and elderly care service facilities';
    'Commercial shopping facilities';
    'Entertainment facilities';
    'Interpersonal emotional support';
    'The richness of activities in the village';
    'Social participation of the elderly';
    'Policy and legal publicity situation';
    'Disposable monthly income of elderly people';

Evaluate whether a rural living environment is suitable for elderly people. BP neural network is used as an evaluation and testing model.