import { Controller, Post, Body, Inject } from '@nestjs/common';
import { PrismaService } from './prisma.service';

@Controller('orders')
export class OrdersController {
  constructor(@Inject(PrismaService) private prisma: PrismaService) {}

  @Post()
  create(@Body() data: { userId: string; items: any; extraRequests: string }) {
    return this.prisma.order.create({ data });
  }
}